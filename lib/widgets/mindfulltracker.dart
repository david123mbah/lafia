import 'package:flutter/material.dart';
import 'package:lafia/utils/colors.dart';
import 'package:lafia/widgets/chartcontainer.dart';

class MindFullTracker extends StatefulWidget {
  const MindFullTracker({super.key});
  @override
  State<MindFullTracker> createState() => _MindFullTrackerState();
}

class _MindFullTrackerState extends State<MindFullTracker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mindful Tracker',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset("lib/assets/Images/mindicons/Solid more vertical.png")
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTrackerCard(
            title: 'Mindful Hours',
            value: '2.5h/8h',
            leftImagePath: 'lib/assets/Images/Icon Container.png',
            rightImagePath: 'lib/assets/Images/Framehhjj.png',
            onTap: () {
              // Add navigation logic
            },
          ),
          _buildTrackerCard(
            title: 'Sleep Quality',
            value: 'Insomniac (~2h Avg)',
            leftImagePath: 'lib/assets/Images/mindicons/sleep.png',
            rightImagePath: 'lib/assets/Images/mindicons/sleeptime.png',
            onTap: () {
              // Add navigation logic
            },
          ),
          _buildTrackerCard(
            title: 'Mindful Journal',
            value: '64 Day Streak',
            leftImagePath: 'lib/assets/Images/mindicons/dbbbc.png',
            rightImagePath: 'lib/assets/Images/mindicons/vcvcv.png',
            trailing: _buildStreakDots(),
            onTap: () {
              // Add navigation logic
            },
          ),
          _buildStressLevelCard(
            onTap: () {
              // Add navigation logic
            },
          ),
          _buildMoodTrackerCard(
            onTap: () {
              // Add navigation logic
            },
          ),
          SizedBox(height: 15,),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AI Therapy Chatbot',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brown400,
                ),
              ),
              Image.asset(
                'lib/assets/Images/mindicons/Solid gear.png',
                width: 24,
                height: 24,
                color: AppColors.brown200,
              ),
            ],
          ),
          SizedBox(height: 15,),
          const Chartcontainer (),
        ],
      ),
    );
  }

  Widget _buildTrackerCard({
    required String title,
    required String value,
    required String leftImagePath,
    required String rightImagePath,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  leftImagePath,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) 
                trailing
              else
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    rightImagePath,
                    width: 44,
                    height: 44,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakDots() {
    return Row(
      children: [
        ...List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Image.asset(
          'lib/assets/Images/mindicons/vcvcv.png',
          width: 24,
          height: 24,
        ),
      ],
    );
  }

  Widget _buildStressLevelCard({required VoidCallback onTap}) {
    return _buildTrackerCard(
      title: 'Stress Level',
      value: 'Level 3 (Normal)',
      leftImagePath: 'lib/assets/Images/mindicons/davidjjv.png',
      rightImagePath: 'lib/assets/Images/stress_right.png',
      onTap: onTap,
      trailing: Row(
        children: [
          Container(
            width: 120,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                Container(
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.yellow.shade700,
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildMoodTrackerCard({required VoidCallback onTap}) {
    return _buildTrackerCard(
      title: 'Mood Tracker',
      value: '',
      leftImagePath: 'lib/assets/Images/mindicons/nem.png',
      rightImagePath: 'lib/assets/Images/mood_right.png',
      onTap: onTap,
      trailing: Row(
        children: [
          Text('SAD', style: TextStyle(color: Colors.grey.shade500)),
          Icon(Icons.arrow_forward, color: Colors.grey.shade400, size: 16),
          Text('NEUTRAL', style: TextStyle(color: Colors.grey.shade500)),
          Icon(Icons.arrow_forward, color: Colors.grey.shade400, size: 16),
          const Text('HAPPY', style: TextStyle(color: Colors.green)),
          const SizedBox(width: 12),
         
        ],
      ),
    );
  }
}