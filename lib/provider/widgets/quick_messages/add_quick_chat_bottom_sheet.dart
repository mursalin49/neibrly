import 'package:flutter/material.dart';
import '../../services/quick_message_service.dart';
import '../../screens/quick_chats_screen.dart';

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
          content: Text(message),
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
                color: const Color(0xFF0E7A60),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.add,
              color: Color(0xFF0E7A60),
              size: 40,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Title
          Text(
            'Add Quick Chat',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Description
          Text(
            'Send preset messages to the provider for faster communication.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Input Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Write answer',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
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
                    borderSide: const BorderSide(color: Color(0xFF0E7A60), width: 2),
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
                    backgroundColor: const Color(0xFF0E7A60),
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
                      : Text(
                          'Done',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                    // Navigate to QuickChatsScreen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuickChatsScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0E7A60),
                    side: const BorderSide(color: Color(0xFF0E7A60), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'See All',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0E7A60),
                    ),
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

