import 'package:flutter/material.dart';
import '../../models/quick_message.dart';
import '../../services/quick_message_service.dart';
import '../../utils/app_colors.dart';
import '../../views/base/AppText/appText.dart';

class EditQuickChatBottomSheet extends StatefulWidget {
  final String initialMessage;
  final String messageId;
  final VoidCallback onMessageUpdated;

  const EditQuickChatBottomSheet({
    super.key,
    required this.initialMessage,
    required this.messageId,
    required this.onMessageUpdated,
  });

  @override
  State<EditQuickChatBottomSheet> createState() => _EditQuickChatBottomSheetState();
}

class _EditQuickChatBottomSheetState extends State<EditQuickChatBottomSheet> {
  late TextEditingController _messageController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController(text: widget.initialMessage);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _updateMessage() async {
    if (_messageController.text.trim().isEmpty) {
      _showSnackBar('Please enter a message');
      return;
    }

    if (_messageController.text.trim() == widget.initialMessage) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await QuickMessageService.updateQuickMessage(
        widget.messageId,
        _messageController.text.trim(),
      );
      
      if (mounted) {
        widget.onMessageUpdated();
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      _showSnackBar(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      _showSnackBar('Please enter a message');
      return;
    }

    // Create a temporary QuickMessage to send
    final message = QuickMessage(
      id: widget.messageId,
      message: _messageController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    Navigator.of(context).pop(message);
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
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          // Header Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E8),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.edit,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Title
          AppText(
            'Edit Quick Chat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.Black,
          ),
          
          const SizedBox(height: 8),
          
          // Description
          AppText(
            'Customize your preset messages for faster responses.',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.DarkGray,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 32),
          
          // Input Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Edit answer',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.Black,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _messageController,
                maxLines: 4,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Type here',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Action Buttons
          Column(
            children: [
              // Send Now Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.send, size: 20),
                      const SizedBox(width: 8),
                      AppText(
                        'Send Now',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Done Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _updateMessage,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0E7A60)),
                          ),
                        )
                      : AppText(
                          'Save Changes',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
