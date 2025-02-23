import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lafia/pages/AIchartboard/conversation.dart';
import 'package:lafia/utils/apptext.dart';


import '../../routes/approutes.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  // Method to navigate to the ConversationsScreen
  void navigateToConversationsScreen(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationsScreen(userId: currentUser.uid),
        ),
      );
    } else {
      // Handle the case where the user is not logged in
      print('User is not logged in.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You must be logged in to access the chat.'),
        ),
      );
      // Optionally, redirect to the login screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'lib/assets/Images/profileIcons/backicons.png',
            width: 54,
            height: 54,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mindful AI Chatbot',
          style: TextStyles.heading2xlSemiBold,
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          // Bot Image
          Image.asset(
            'lib/assets/Images/profileIcons/chatai.png',
            height: 314.12,
            width: 289.86,
          ),
          const SizedBox(height: 24),
          // Title
          const Text(
            'Talk to Doctor Lafia AI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3A2D27),
            ),
          ),
          const SizedBox(height: 12),
          // Subtitle
          const Text(
            'You have no AI conversations. Get your\nmind healthy by starting a new one.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          // New Conversation Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: () {
                // Replace Get.toNamed with navigateToConversationsScreen
                navigateToConversationsScreen(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7F57),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New Conversation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Bottom Safe Area
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}