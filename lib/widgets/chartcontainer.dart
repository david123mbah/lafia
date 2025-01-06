import 'package:flutter/material.dart';

class Chartcontainer extends StatelessWidget {
  const Chartcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF5D4037), // Brown background
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('lib/assets/Images/mindicons/robot.png'),
          fit: BoxFit.contain,
          opacity: 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
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
                'lib/assets/Images/mindicons/message.png',
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
                'lib/assets/Images/mindicons/Vectorbb.png',
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
                'lib/assets/Images/Solid starf.png',
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
        
        ],
      ),
    );
  }

}