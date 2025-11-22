import 'package:flutter/material.dart';
import '../../services/quick_message_service.dart';
import '../../views/screen/Users/Request/user_quick_chats_screen.dart';
import '../../utils/app_colors.dart';
import '../../views/base/AppText/appText.dart';

class AddQuickChatBottomSheet extends StatefulWidget {
  const AddQuickChatBottomSheet({super.key});

  @override
  State<AddQuickChatBottomSheet> createState() => _AddQuickChatBottomSheetState();
}

class _AddQuickChatBottomSheetState extends State<AddQuickChatBottomSheet> {
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _addMessage() async {
    if (_messageController.text.trim().isEmpty) {
      _showSnackBar('Please enter a message');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Check if we can add more messages
      final canAdd = await QuickMessageService.canAddMoreMessages();
      if (!canAdd) {
        _showSnackBar('Maximum of ${QuickMessageService.getMaxMessages()} messages allowed');
        return;
      }

      await QuickMessageService.addQuickMessage(_messageController.text.trim());
      
      if (mounted) {
        Navigator.of(context).pop(true); // Return true to indicate success
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
              Icons.add,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Title
          AppText(
            'Add Quick Chat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.Black,
          ),
          
          const SizedBox(height: 8),
          
          // Description
          AppText(
            'Send preset messages to the provider for faster communication.',
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
                'Write answer',
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
              // Done Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _addMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : AppText(
                          'Done',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // See All Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to UserQuickChatsScreen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UserQuickChatsScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: AppText(
                    'See All',
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
