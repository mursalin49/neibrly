import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quick_message.dart';

class QuickMessageService {
  static const String _storageKey = 'user_quick_messages';
  static const int _maxMessages = 15;

  // Get all saved quick messages
  static Future<List<QuickMessage>> getQuickMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? messagesJson = prefs.getString(_storageKey);
      
      if (messagesJson == null) {
        return [];
      }
      
      final List<dynamic> messagesList = json.decode(messagesJson);
      return messagesList
          .map((json) => QuickMessage.fromJson(json))
          .toList();
    } catch (e) {
      // Error loading quick messages: $e
      return [];
    }
  }

  // Save a new quick message
  static Future<bool> addQuickMessage(String message) async {
    try {
      final messages = await getQuickMessages();
      
      // Check if we've reached the limit
      if (messages.length >= _maxMessages) {
        throw Exception('Maximum of $_maxMessages messages allowed');
      }
      
      // Check if message already exists
      if (messages.any((msg) => msg.message.trim() == message.trim())) {
        throw Exception('Message already exists');
      }
      
      final newMessage = QuickMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      messages.add(newMessage);
      return await _saveMessages(messages);
    } catch (e) {
      // Error adding quick message: $e
      rethrow;
    }
  }

  // Update an existing quick message
  static Future<bool> updateQuickMessage(String id, String newMessage) async {
    try {
      final messages = await getQuickMessages();
      final messageIndex = messages.indexWhere((msg) => msg.id == id);
      
      if (messageIndex == -1) {
        throw Exception('Message not found');
      }
      
      // Check if the new message already exists (excluding current message)
      if (messages.any((msg) => msg.id != id && msg.message.trim() == newMessage.trim())) {
        throw Exception('Message already exists');
      }
      
      messages[messageIndex] = messages[messageIndex].copyWith(
        message: newMessage.trim(),
        updatedAt: DateTime.now(),
      );
      
      return await _saveMessages(messages);
    } catch (e) {
      // Error updating quick message: $e
      rethrow;
    }
  }

  // Delete a quick message
  static Future<bool> deleteQuickMessage(String id) async {
    try {
      final messages = await getQuickMessages();
      messages.removeWhere((msg) => msg.id == id);
      return await _saveMessages(messages);
    } catch (e) {
      // Error deleting quick message: $e
      rethrow;
    }
  }

  // Check if we can add more messages
  static Future<bool> canAddMoreMessages() async {
    final messages = await getQuickMessages();
    return messages.length < _maxMessages;
  }

  // Get current message count
  static Future<int> getMessageCount() async {
    final messages = await getQuickMessages();
    return messages.length;
  }

  // Get maximum allowed messages
  static int getMaxMessages() => _maxMessages;

  // Save messages to storage
  static Future<bool> _saveMessages(List<QuickMessage> messages) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = json.encode(
        messages.map((msg) => msg.toJson()).toList(),
      );
      return await prefs.setString(_storageKey, messagesJson);
    } catch (e) {
      // Error saving quick messages: $e
      return false;
    }
  }
}
