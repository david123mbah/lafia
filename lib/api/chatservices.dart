import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';

// constants.dart
class Constants {
  static const String HUMI_AI_API_KEY = "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";
}

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final OpenAI _openAI;

  ChatService() {
    _initializeOpenAI();
  }

  void _initializeOpenAI() {
    _openAI = OpenAI.instance.build(
      token: Constants.HUMI_AI_API_KEY,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 120),
        connectTimeout: const Duration(seconds: 120),
      ),
      enableLog: true,
    );
  }

  // Fetch chat history for a specific user
  Stream<List<ChatMessage>> getChatHistory(String userId) {
    if (userId.isEmpty) {
      throw ArgumentError('User ID must not be empty');
    }

    return _firestore
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ChatMessage(
          user: ChatUser(
            id: data['isUser'] ? '1' : '2',
            firstName: data['isUser'] ? 'User' : 'Doctor Freud.AI',
          ),
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          text: data['text'],
        );
      }).toList();
    });
  }

  // Save message to Firebase
  Future<void> saveMessage(String userId, ChatMessage message, bool isUser) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID must not be empty');
    }

    try {
      await _firestore
          .collection('chats')
          .doc(userId)
          .collection('messages')
          .add({
        'text': message.text,
        'isUser': isUser,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error saving message to Firebase: $e');
      throw Exception('Failed to save message');
    }
  }

  // Get response from HUMI_AI
  Future<String> getGPTResponse(String message) async {
    try {
      final request = ChatCompleteText(
        messages: [
          {
            'role': 'user',
            'content': message,
          },
        ],
        model: GptTurbo0301ChatModel(), // Adjust the model as needed
        maxToken: 2000,
        temperature: 0.7,
      );

      final response = await _openAI.onChatCompletion(request: request);

      if (response != null && response.choices.isNotEmpty) {
        return response.choices[0].message?.content ?? 'No content available';
      } else {
        throw Exception('Empty response received');
      }
    } catch (e) {
      print('Error getting HUMI_AI response: $e');
      return 'I apologize, but I encountered an error. Please try again.';
    }
  }

  // Handle errors
  void handleError(dynamic error) {
    print('ChatService Error: $error');
  }

  // Dispose of the OpenAI instance
  void dispose() {
    try {
      // _openAI.close(); // Commented out because the method is not defined for OpenAI
    } catch (e) {
      print('Error disposing ChatService: $e');
    }
  }
}