import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lafia/api/chatservices.dart';

class ConversationsScreen extends StatefulWidget {
  final String userId;

  const ConversationsScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'User');
  final ChatUser _botUser = ChatUser(id: '2', firstName: 'Doctor Freud.AI');
  late ChatService _chatService;
  List<ChatMessage> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.userId.isEmpty) {
      throw ArgumentError('User ID must not be empty');
    }
    _chatService = ChatService();
    _loadChatHistory();
  }

  void _loadChatHistory() {
    if (widget.userId.isEmpty) {
      print('User ID is empty. Cannot load chat history.');
      return;
    }

    _chatService.getChatHistory(widget.userId).listen((messages) {
      setState(() {
        _messages = messages;
      });
    });
  }

  Future<void> _handleSendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final userMessage = ChatMessage(
      user: _currentUser,
      createdAt: DateTime.now(),
      text: text,
    );

    // Save user message
    await _chatService.saveMessage(widget.userId, userMessage, true);

    // Get GPT response
    final response = await _chatService.getGPTResponse(text);

    // Create bot message
    final botMessage = ChatMessage(
      user: _botUser,
      createdAt: DateTime.now(),
      text: response,
    );

    // Save bot message
    await _chatService.saveMessage(widget.userId, botMessage, false);

    // Clear the input field
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Freud.AI',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isCurrentUser = message.user.id == _currentUser.id;

                return Align(
                  alignment: isCurrentUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? Colors.blue
                          : Color(0xFF94B07A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(
                            color: isCurrentUser ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${message.createdAt.hour}:${message.createdAt.minute}',
                          style: TextStyle(
                            color: isCurrentUser
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type to start chatting...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    onSubmitted: (text) {
                      _handleSendMessage();
                    },
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _handleSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}