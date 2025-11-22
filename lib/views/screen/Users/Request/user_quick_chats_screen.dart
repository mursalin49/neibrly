import 'package:flutter/material.dart';
import 'package:naibrly/models/quick_message.dart';
import 'package:naibrly/services/quick_message_service.dart';
import 'package:naibrly/widgets/quick_messages/edit_quick_chat_bottom_sheet.dart';
import 'package:naibrly/widgets/quick_messages/add_quick_chat_bottom_sheet.dart';
import 'package:naibrly/utils/app_colors.dart';
import 'package:naibrly/views/base/AppText/appText.dart';

class UserQuickChatsScreen extends StatefulWidget {
  const UserQuickChatsScreen({super.key});

  @override
  State<UserQuickChatsScreen> createState() => _UserQuickChatsScreenState();
}

class _UserQuickChatsScreenState extends State<UserQuickChatsScreen> {
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
    // Navigate back to UserRequestInboxScreen and send the message
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
        title: AppText(
          'Delete Message',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.Black,
        ),
        content: AppText(
          'Are you sure you want to delete this message?\n\n"$message"',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.DarkGray,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: AppText(
              'Cancel',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.DarkGray,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: AppText(
              'Delete',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ) ?? false;
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            message,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
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
        title: AppText(
          'Quick Chats',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.Black,
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
              backgroundColor: AppColors.primary,
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
          AppText(
            'No Quick Messages',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.DarkGray,
          ),
          const SizedBox(height: 8),
          AppText(
            'Add your first quick message to get started',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.DarkGray,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _showAddMessageDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: AppText(
              'Add First Message',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
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
            title: AppText(
              message.message,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.Black,
              maxLines: 3,
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
                PopupMenuItem(
                  value: 'send',
                  child: Row(
                    children: [
                      Icon(Icons.send, size: 20, color: AppColors.primary),
                      const SizedBox(width: 8),
                      AppText(
                        'Send Now',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit, size: 20),
                      const SizedBox(width: 8),
                      AppText(
                        'Edit',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Black,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, size: 20, color: Colors.red),
                      const SizedBox(width: 8),
                      AppText(
                        'Delete',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
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
