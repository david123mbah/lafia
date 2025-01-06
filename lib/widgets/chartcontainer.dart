import 'package:flutter/material.dart';

class Chartcontainer extends StatelessWidget {
  const Chartcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF5D4037), // Brown background
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('lib/assets/Images/robot_pattern.png'),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AI Therapy Chatbot',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Image.asset(
                'lib/assets/Images/settings_icon.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              const Text(
                '2541',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'lib/assets/Images/message_icon.png',
                width: 48,
                height: 48,
                color: Colors.white,
              ),
            ],
          ),
          const Text(
            'Conversations',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Image.asset(
                'lib/assets/Images/chat_bubble.png',
                width: 24,
                height: 24,
                color: Colors.white70,
              ),
              const SizedBox(width: 8),
              const Text(
                '83 left this month',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Image.asset(
                'lib/assets/Images/star_icon.png',
                width: 24,
                height: 24,
                color: Colors.white70,
              ),
              const SizedBox(width: 8),
              const Text(
                'Go Pro, Now!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFloatingButton(
                color: const Color(0xFF8BC34A), // Light green
                icon: Icons.add,
                onTap: () {
                  // Add new conversation logic
                },
              ),
              const SizedBox(width: 16),
              _buildFloatingButton(
                color: const Color(0xFFFF5722), // Deep orange
                icon: Icons.settings,
                onTap: () {
                  // Open settings logic
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton({
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}