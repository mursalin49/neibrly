import 'dart:async';
import 'package:flutter/material.dart';
import 'package:naibrly/models/user_request.dart';
import 'package:naibrly/models/quick_message.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';
// Preset quick questions only; add/edit screens not used
import 'package:naibrly/widgets/payment_confirmation_bottom_sheet.dart';
import 'package:naibrly/widgets/naibrly_now_bottom_sheet.dart';
import 'package:naibrly/views/screen/Users/Request/review_confirm_screen.dart';

class UserRequestInboxScreen extends StatefulWidget {
  final UserRequest request;

  const UserRequestInboxScreen({
    super.key,
    required this.request,
  });

  @override
  State<UserRequestInboxScreen> createState() => _UserRequestInboxScreenState();
}

class _UserRequestInboxScreenState extends State<UserRequestInboxScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isWaitingForAcceptance = false;
  bool _showFeedback = false;
  bool _isCancelled = false;
  String? _cancellationReason;
  DateTime? _cancellationTime;
  List<QuickMessage> _quickMessages = [];
  
  // Timer and completion request state
  bool _showCompletionRequest = false;
  int _timerCountdown = 10;
  Timer? _timer;
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Your service request has been confirmed!",
      isFromUser: false,
      isFromProvider: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ChatMessage(
      text: "Thank you for confirming your order! I'll begin work shortly.",
      isFromUser: true,
      isFromProvider: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Check if request is cancelled based on request status
    _isCancelled = widget.request.status == RequestStatus.cancelled;
    
    // If request is already cancelled, set up cancellation data
    if (_isCancelled) {
      _cancellationReason = widget.request.cancellationReason ?? 'The service was no longer required due to unforeseen circumstances.';
      _cancellationTime = widget.request.cancellationTime ?? DateTime.now();
    }
    
    // Check if request is done - if so, show feedback immediately
    if (widget.request.status == RequestStatus.done) {
      _showFeedback = true;
    }
    
    // Start timer for accepted requests
    if (widget.request.status == RequestStatus.accepted) {
      _startCompletionTimer();
    }
    
    // Load quick messages
    _loadQuickMessages();
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

  void _sendQuickMessage(QuickMessage message) {
    // Add the quick message to the chat
    setState(() {
      _messages.add(ChatMessage(
        text: message.message,
        isFromUser: true,
        isFromProvider: false,
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

  // Add/Edit quick chats disabled in preset mode

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCompletionTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _timerCountdown--;
        });
        
        if (_timerCountdown <= 0) {
          timer.cancel();
          setState(() {
            _showCompletionRequest = true;
          });
        }
      }
    });
  }

  void _handleAcceptCompletion() {
    // Navigate to review and confirm screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReviewConfirmScreen(request: widget.request),
      ),
    );
  }

  void _handleCancelCompletion() {
    setState(() {
      _showCompletionRequest = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task completion cancelled.'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB), // Match provider background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppText(
          _isCancelled ? 'Cancelled' : 'Request Inbox',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: (_isWaitingForAcceptance || _showFeedback || _isCancelled || widget.request.status == RequestStatus.done) ? null : () {
                _showCancelRequestDialog();
              },
              style: TextButton.styleFrom(
                backgroundColor: (_isWaitingForAcceptance || _showFeedback || _isCancelled || widget.request.status == RequestStatus.done)
                  ? Colors.grey[300] 
                  : const Color(0xFFFEEEEE), // Light red background
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: AppText(
                _isCancelled ? 'Cancelled' : (widget.request.status == RequestStatus.done ? 'Completed' : 'Cancel'),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: (_isWaitingForAcceptance || _showFeedback || _isCancelled || widget.request.status == RequestStatus.done)
                  ? Colors.grey[600] 
                  : const Color(0xFFF34F4F), // Red text
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Request Details Card
              _buildRequestDetailsCard(),
              
              // Chat Messages and Feedback
              _showFeedback
                ? Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: _buildChatMessages(),
                      ),
                      _buildFeedbackMessage(),
                    ],
                  )
                : SizedBox(
                    height: 200,
                    child: _buildChatMessages(),
                  ),
              
              // Pending message
              if (_isWaitingForAcceptance)
                _buildWaitingMessage(),
              
              // Cancellation messages or Quick Reply Buttons
              if (_isCancelled) ...[
                // Cancellation reason text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: AppText(
                    _cancellationReason ?? 'The service was no longer required due to unforeseen circumstances.',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.DarkGray,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Cancellation reason bubble
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0), // Light gray bubble color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppText(
                    'Cancellation reason provided by you.',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.DarkGray,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Cancellation timestamp
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 10),
                  child: AppText(
                    _cancellationTime != null
                        ? '${_cancellationTime!.hour}:${_cancellationTime!.minute.toString().padLeft(2, '0')} PM'
                        : '1:44 PM', // Fallback if time is null
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.DarkGray,
                    textAlign: TextAlign.center,
                  ),
                ),
              ] else if (!_isWaitingForAcceptance && !_showFeedback && !_showCompletionRequest) ...[
                _buildQuickReplies(),
              ],
              
              // Timer countdown (for accepted requests before completion request)
              if (widget.request.status == RequestStatus.accepted && !_showCompletionRequest && _timerCountdown > 0)
                _buildCountdownCard(),
              
              // Completion Request Card (for accepted requests after timer)
              if (_showCompletionRequest)
                _buildCompletionRequestCard(),
              
              // Add bottom padding to prevent FAB overlap
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildRequestDetailsCard() {
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
              AppText(
                '${widget.request.serviceName}: ',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.Black,
              ),
              AppText(
                '\$${widget.request.averagePrice.toInt()}/hr',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Provider Info
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(widget.request.providerImage),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    widget.request.providerName,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.Black,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 2),
                      AppText(
                        '${widget.request.providerRating} (${widget.request.providerReviewCount} reviews)',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.DarkGray,
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
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.Black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: widget.request.address,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.DarkGray,
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
              AppText(
                'Date: ${widget.request.formattedDate} Time: ${widget.request.time}',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.DarkGray,
              ),
            ],
          ),
          
          // Problem Note
          if (widget.request.problemDescription != null) ...[
            const SizedBox(height: 8),
            AppText(
              'Problem Note for ${widget.request.serviceName}',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.Black,
            ),
            const SizedBox(height: 4),
            AppText(
              widget.request.problemDescription!,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.DarkGray,
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
            child: AppText(
              'Today',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.DarkGray,
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
            ? MainAxisAlignment.end 
            : MainAxisAlignment.start,
        children: [
          if (!message.isFromUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(widget.request.providerImage),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: message.isFromUser 
                    ? AppColors.primary
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    message.text,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: message.isFromUser ? Colors.white : AppColors.Black,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    _formatTime(message.timestamp),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: message.isFromUser ? Colors.white70 : AppColors.DarkGray,
                  ),
                ],
              ),
            ),
          ),
          if (message.isFromUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.person, size: 16, color: Colors.blue),
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
                    child: AppText(
                      'No quick questions available at the moment.',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.DarkGray,
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
              AppText(
                'Quick Questions',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.DarkGray,
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
                      child: AppText(
                        message.message,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8B4513),
                        maxLines: 2,
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

  void _showCancelRequestDialog() {
    showCancelRequestBottomSheet(
      context,
      onNaibrlyNow: () {
        // Open Naibrly Now sheet with current request info
        showNaibrlyNowBottomSheet(
          context,
          serviceName: widget.request.serviceName,
          providerName: widget.request.providerName,
        );
      },
      onCancelConfirmed: (reason) {
        setState(() {
          _isCancelled = true;
          _cancellationReason = reason;
          _cancellationTime = DateTime.now();
        });
      },
    );
  }


  Widget _buildWaitingMessage() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
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
              color: AppColors.primary,
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
                AppText(
                  'Please wait for acceptance from ${widget.request.providerName}',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 4),
                AppText(
                  'Your request is pending approval.',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.DarkGray,
                ),
              ],
            ),
          ),
        ],
      ),
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
          AppText(
            'Received feedback from the provider',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.Black,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          
          // Feedback message
          AppText(
            'Thank you for your order! It was a pleasure working on your request. I hope the service met your expectations. Please feel free to reach out if you need anything else!',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.DarkGray,
            textAlign: TextAlign.center,
            maxLines: 3,
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
              child: AppText(
                'Done',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.Black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Report provider link
          TextButton(
            onPressed: () {
              // Handle report provider
            },
            child: AppText(
              'Report Provider',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.DarkGray,
              decoration: TextDecoration.underline,
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

  Widget _buildCountdownCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          AppText(
            'Task completion request will appear in',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.DarkGray,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          AppText(
            '$_timerCountdown seconds',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0E7A60),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionRequestCard() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x0500CD49), // 2% #00CD4905
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0x4D00CD49), // 30% #00CD494D
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Request Amount
          Row(
            children: [
              AppText(
                'Request Amount:',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.Black,
              ),
              const SizedBox(width: 6),
              AppText(
                '\$${widget.request.averagePrice.toInt()}/consult',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0E7A60),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Service details
          AppText(
            '${widget.request.serviceName}: \$${widget.request.averagePrice.toInt()}/hr',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.Black,
          ),
          
          const SizedBox(height: 8),
          
          // Provider info
          Row(
            children: [
              // Provider image
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(widget.request.providerImage),
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(width: 8),
              // Provider name and review in a row
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    widget.request.providerName,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.Black,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      AppText(
                        '${widget.request.providerRating} (${widget.request.providerReviewCount} reviews)',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.DarkGray,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Description
          AppText(
            'Task Accept Request from ${widget.request.providerName}. Accept the request to complete the task. Thank you!',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.DarkGray,
          ),
          
          const SizedBox(height: 12),
          
          // Action buttons
          Row(
            children: [
              // Cancel button
              Expanded(
                child: OutlinedButton(
                  onPressed: _handleCancelCompletion,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: AppText(
                    'Cancel',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
              
              const SizedBox(width: 10),
              
              // Accept button
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleAcceptCompletion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E7A60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 0,
                  ),
                  child: AppText(
                    'Accept',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Time and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                '1:44 PM',
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.DarkGray,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AppText(
                  'Waiting for accepted',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.Black,
                ),
              ),
            ],
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
