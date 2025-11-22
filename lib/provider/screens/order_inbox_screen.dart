import 'package:flutter/material.dart';
import '../widgets/colors.dart';
import '../models/order.dart';
import '../models/quick_message.dart';
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';

class OrderInboxScreen extends StatefulWidget {
  final Order order;

  const OrderInboxScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderInboxScreen> createState() => _OrderInboxScreenState();
}

class _OrderInboxScreenState extends State<OrderInboxScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isWaitingForAcceptance = false;
  bool _showFeedback = false;
  bool _isCancelled = false;
  List<QuickMessage> _quickMessages = [];
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Your service request has been confirmed!",
      isFromUser: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatMessage(
      text: "Thank you for confirming your order! I'll begin work shortly.",
      isFromProvider: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Check if order is cancelled based on order status
    _isCancelled = widget.order.status == OrderStatus.cancelled;
    
    // Check if order is completed - if so, show feedback immediately
    if (widget.order.status == OrderStatus.completed) {
      _showFeedback = true;
    }
    
    // Load quick messages
    _loadQuickMessages();
  }

  void _startFeedbackTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isWaitingForAcceptance = false;
          _showFeedback = true;
        });
      }
    });
  }

  Future<void> _loadQuickMessages() async {
    final now = DateTime.now();
    final List<String> presetQuestions = [
      'How long does this job usually take?',
      'Do I need to do anything to prepare before you arrive?',
      'Do you bring your own tools and supplies, or do I need to provide anything?',
      'Can you provide me an update when you will arrive?',
      'Are you able to message me before you arrive?',
      'Can you message me when the job is complete?',
      'Is there an additional fee for same-day service?',
      'Will there be any cleanup required after the job?',
      'Do you offer any warranty or guarantee for the work?',
      'What is the best contact number to reach you if needed?',
    ];
    setState(() {
      _quickMessages = presetQuestions.asMap().entries.map((entry) {
        final i = entry.key;
        final text = entry.value;
        return QuickMessage(
          id: 'preset_$i',
          message: text,
          createdAt: now,
          updatedAt: now,
        );
      }).toList();
    });
  }

  void _sendQuickMessage(QuickMessage message) {
    // Add the quick message to the chat
    setState(() {
      _messages.add(ChatMessage(
        text: message.message,
        isFromProvider: true,
        timestamp: DateTime.now(),
      ));
    });

    // Auto-scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

  }

  // Preset quick questions only; add/navigate screens disabled

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KoreColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Order Inbox',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: (_isWaitingForAcceptance || _showFeedback || _isCancelled || widget.order.status == OrderStatus.completed) ? null : () {
                _showTaskDoneBottomSheet();
              },
              style: TextButton.styleFrom(
                backgroundColor: (_isWaitingForAcceptance || _showFeedback || _isCancelled || widget.order.status == OrderStatus.completed)
                  ? Colors.grey[300] 
                  : const Color(0xFF0E7A60),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _isCancelled ? 'Cancelled' : (widget.order.status == OrderStatus.completed ? 'Completed' : 'Task Done'),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: (_isWaitingForAcceptance || _showFeedback || _isCancelled || widget.order.status == OrderStatus.completed)
                    ? Colors.grey[600] 
                    : Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _isCancelled 
          ? _buildCancelledOrderView()
          : Column(
              children: [
                // Order Details Card
                _buildOrderDetailsCard(),
                
                // Chat Messages and Feedback (scrollable together)
                Expanded(
                  child: _showFeedback
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: _buildChatMessages(),
                            ),
                            _buildFeedbackMessage(),
                          ],
                        ),
                      )
                    : _buildChatMessages(),
                ),
                
                // Pending message
                if (_isWaitingForAcceptance)
                  _buildWaitingMessage(),
                
                // Quick Reply Buttons
                if (!_isWaitingForAcceptance && !_showFeedback)
                  _buildQuickReplies(),
              ],
            ),
      ),
      floatingActionButton: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildOrderDetailsCard() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Type and Rate
          Row(
            children: [
              Text(
                '${widget.order.serviceName}: ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${widget.order.averagePrice.toInt()}/hr',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0E7A60),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Provider Info
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.grey, size: 16),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.order.clientName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.black, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '${widget.order.clientRating} (${widget.order.clientReviewCount} reviews)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Address
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Address: ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: widget.order.address,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          
          // Date and Time
          Row(
            children: [
              Text(
                'Date: ${widget.order.formattedDate} Time: ${widget.order.time}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          
          // Problem Note
          if (widget.order.problemDescription != null) ...[
            const SizedBox(height: 8),
            Text(
              'Problem Note for Fridge Repair',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.order.problemDescription!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[700],
                height: 1.3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Today separator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Today',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: message.isFromUser 
            ? MainAxisAlignment.start 
            : MainAxisAlignment.end,
        children: [
          if (message.isFromUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 16, color: Colors.grey),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: message.isFromUser 
                    ? Colors.grey[200] 
                    : const Color(0xFF0E7A60),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: message.isFromUser ? Colors.black : Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatTime(message.timestamp),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: message.isFromUser ? Colors.grey[600] : Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isFromProvider) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.home, size: 16, color: Colors.blue),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    if (_quickMessages.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.message_outlined, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'No quick questions available at the moment.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with "See All" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Questions',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Scrollable quick message buttons (show all messages)
          SizedBox(
            height: 120, // Fixed height for scrollable area
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _quickMessages.length,
              itemBuilder: (context, index) {
                final message = _quickMessages[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: InkWell(
                    onTap: () => _sendQuickMessage(message),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7D6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF1C400), width: 1),
                      ),
                      child: Text(
                        message.message,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF8B4513),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  void _showTaskDoneBottomSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskDoneBottomSheet(
        order: widget.order,
        onTaskCompleted: () {
          Navigator.of(context).pop();
          setState(() {
            _isWaitingForAcceptance = true;
          });
          _startFeedbackTimer();
        },
      ),
    );
  }

  Widget _buildWaitingMessage() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0E7A60).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF0E7A60).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Clock icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0E7A60),
            ),
            child: const Icon(
              Icons.access_time,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // Waiting message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please wait for acceptance from ${widget.order.clientName}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0E7A60),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your task completion is pending approval.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelledOrderView() {
    return Column(
      children: [
        // Order Details Card
        _buildOrderDetailsCard(),
        
        // Cancelled content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancellation reason
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'The service was no longer required due to unforeseen circumstances.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Cancellation reason label
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Text(
                    'Cancellation reason provided by you',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blue[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Timestamp
                Text(
                  '1:44 PM',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Report customer link
                TextButton(
                  onPressed: () {
                    // Handle report customer
                  },
                  child: Text(
                    'Report Customer',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackMessage() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Feedback image
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/images/clientFeedback.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Title
          Text(
            'Received feedback from the provider',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          
          // Feedback message
          Text(
            'Thank you for your order! It was a pleasure working on your request. I hope the service met your expectations. Please feel free to reach out if you need anything else!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
              fontSize: 12,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          
          // Star rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => 
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Done button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showFeedback = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
                elevation: 0,
              ),
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Report customer link
          TextButton(
            onPressed: () {
              // Handle report customer
            },
            child: Text(
              'Report Customer',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontSize: 11,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
}

class TaskDoneBottomSheet extends StatefulWidget {
  final Order order;
  final VoidCallback? onTaskCompleted;

  const TaskDoneBottomSheet({
    super.key,
    required this.order,
    this.onTaskCompleted,
  });

  @override
  State<TaskDoneBottomSheet> createState() => _TaskDoneBottomSheetState();
}

class _TaskDoneBottomSheetState extends State<TaskDoneBottomSheet> {
  final TextEditingController _amountController = TextEditingController(text: '\$500');

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Success icon with shadow
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0E7A60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Title
                Text(
                  'Task Completed',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 6),
                
                // Budget info
                Text(
                  'Your Budget avg. \$${widget.order.averagePrice.toInt()}/hr',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Amount input section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount*',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _amountController,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: '\$500',
                        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF0E7A60),
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Done button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onTaskCompleted?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E7A60),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Done',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isFromUser;
  final bool isFromProvider;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    this.isFromUser = false,
    this.isFromProvider = false,
    required this.timestamp,
  });
}
