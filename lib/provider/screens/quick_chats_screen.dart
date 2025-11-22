import 'package:flutter/material.dart';
import '../models/quick_message.dart';
import '../services/quick_message_service.dart';
import '../widgets/quick_messages/edit_quick_chat_bottom_sheet.dart';
import '../widgets/quick_messages/add_quick_chat_bottom_sheet.dart';

class QuickChatsScreen extends StatefulWidget {
  const QuickChatsScreen({super.key});

  @override
  State<QuickChatsScreen> createState() => _QuickChatsScreenState();
}

class _QuickChatsScreenState extends State<QuickChatsScreen> {
  List<QuickMessage> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final messages = await QuickMessageService.getQuickMessages();
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error loading messages: $e');
    }
  }

  Future<void> _deleteMessage(QuickMessage message) async {
    final confirmed = await _showDeleteConfirmation(message.message);
    if (!confirmed) return;

    try {
      await QuickMessageService.deleteQuickMessage(message.id);
      await _loadMessages();
    } catch (e) {
      _showSnackBar('Error deleting message: $e');
    }
  }

  void _sendMessage(QuickMessage message) {
    // Navigate back to OrderInboxScreen and send the message
    Navigator.of(context).pop(message);
  }

  Future<void> _editMessage(QuickMessage message) async {
    final result = await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: EditQuickChatBottomSheet(
          initialMessage: message.message,
          messageId: message.id,
          onMessageUpdated: () {
            _loadMessages();
          },
        ),
      ),
    );

    if (result == true) {
      _loadMessages();
    } else if (result is QuickMessage) {
      // Message was sent from edit dialog
      Navigator.of(context).pop(result);
    }
  }

  Future<bool> _showDeleteConfirmation(String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: Text('Are you sure you want to delete this message?\n\n"$message"'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: message.contains('successfully') ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Quick Chats',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _messages.isEmpty
              ? _buildEmptyState()
              : _buildMessagesList(),
      floatingActionButton: _canAddMoreMessages()
          ? FloatingActionButton(
              onPressed: _showAddMessageDialog,
              backgroundColor: const Color(0xFF0E7A60),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.message_outlined,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Quick Messages',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first quick message to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _showAddMessageDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E7A60),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Add First Message'),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              message.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'send':
                    _sendMessage(message);
                    break;
                  case 'edit':
                    _editMessage(message);
                    break;
                  case 'delete':
                    _deleteMessage(message);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'send',
                  child: Row(
                    children: [
                      Icon(Icons.send, size: 20, color: Color(0xFF0E7A60)),
                      SizedBox(width: 8),
                      Text('Send Now', style: TextStyle(color: Color(0xFF0E7A60))),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _canAddMoreMessages() {
    return _messages.length < QuickMessageService.getMaxMessages();
  }

  void _showAddMessageDialog() {
    showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddQuickChatBottomSheet(),
      ),
    ).then((result) {
      if (result == true) {
        _loadMessages();
      }
    });
  }
}

