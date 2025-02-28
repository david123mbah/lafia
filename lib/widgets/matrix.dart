import 'package:flutter/material.dart';
import 'package:lafia/screens/Mental-heath-score/mentalhealthchat.dart';
import 'package:lafia/screens/Mental-heath-score/mentalscore.dart';
import 'package:lafia/screens/Mental-heath-score/moodstatistics.dart';
import 'package:lafia/widgets/custom_progress.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HealthMatrix extends StatefulWidget {
  const HealthMatrix({super.key});

  @override
  State<HealthMatrix> createState() => _HealthMatrixState();
}

class _HealthMatrixState extends State<HealthMatrix> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    final double offset = _scrollController.offset;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double scrollPercentage = offset / maxScroll;
    setState(() {
      _currentIndex = (scrollPercentage * 2).round(); // 3 cards, so 2 steps
    });
  }

  @override
  Widget build(BuildContext context) {
    const cardWidth = 163.0; // Fixed width as per design
    const cardHeight = 200.0; // Fixed height as per design

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mental Health Metrics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A4A4A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: cardHeight, // Fixed height for the row
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: [
                _buildFreudScoreCard(cardWidth, cardHeight)
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideX()
                    .shimmer(duration: 1200.ms),
                const SizedBox(width: 16),
                _buildMoodCard(cardWidth, cardHeight)
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideX()
                    .shimmer(duration: 1200.ms),
                const SizedBox(width: 16),
                _buildHealthJournalCard(cardWidth, cardHeight)
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideX()
                    .shimmer(duration: 1200.ms),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomProgressIndicator(
            current: _currentIndex + 1, // Progress starts from 1
            total: 3, // Total number of cards
          ),
        ],
      ),
    );
  }

  Widget _buildFreudScoreCard(double width, double height) {
    return InkWell(
      onTap: () {
        // Handle tap
        Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MentalHealthScore()),
                    );

      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFA4B794),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.favorite, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  'health Score',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 10.0,
                percent: 0.8,
                center: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '80',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Healthy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                progressColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCard(double width, double height) {
    return InkWell(
      onTap: () {
        // Handle tap
        Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MentalHealth()),
                    );
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFF7F50),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.mood_bad, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Mood',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Sad',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  11,
                  (index) => Container(
                    width: 8,
                    height: _getMoodBarHeight(index),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthJournalCard(double width, double height) {
    return InkWell(
      onTap: () {
        // Handle tap
      },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF9370DB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.medical_services, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Health Journal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              '31/365',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                10,
                (index) => Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: index < 8
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMoodBarHeight(int index) {
    // Simulate the mood graph pattern from the design
    final heights = [
      30.0,
      40.0,
      50.0,
      70.0,
      90.0,
      100.0,
      80.0,
      60.0,
      40.0,
      30.0,
      20.0
    ];
    return heights[index];
  }
}

