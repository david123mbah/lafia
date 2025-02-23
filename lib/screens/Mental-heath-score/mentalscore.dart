import 'package:flutter/material.dart';
import 'package:lafia/screens/Mental-heath-score/mentalhealthchat.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MentalHealthScore extends StatefulWidget {
  const MentalHealthScore({super.key});
  @override
  State<MentalHealthScore> createState() => _MentalHealthScoreState();
}

class _MentalHealthScoreState extends State<MentalHealthScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFABC4AB),
      body: CustomPaint(
        painter: BackgroundPatternPainter(),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ).animate().fadeIn(duration: 500.ms),
                        // Freud Score Text
                        const Text(
                          'Health Score',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                        // Normal Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'NORMAL',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Score Display
                    const Text(
                      '80',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
                    const Text(
                      'Congratulations! You are\nmentally healthy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Add Button
              InkWell(
               onTap:  () {
        
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A3434),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ).animate().fadeIn(delay: 1000.ms, duration: 500.ms),
              const SizedBox(height: 20),
              // Score History Section
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mental Score History',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A3434),
                            ),
                          ).animate().fadeIn(delay: 1200.ms, duration: 500.ms),
                          IconButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Color(0xFF4A3434),
                            ),
                            onPressed: () {},
                          ).animate().fadeIn(delay: 1400.ms, duration: 500.ms),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // History Cards
                      _buildHistoryCard(
                        date: 'SEP\n12',
                        mood: 'Anxious, Depressed',
                        recommendation: 'Please do 25m Mindfulness.',
                        score: 65,
                        color: Colors.orange,
                      ).animate().fadeIn(delay: 1600.ms, duration: 500.ms),
                      const SizedBox(height: 12),
                      _buildHistoryCard(
                        date: 'SEP\n11',
                        mood: 'Very Happy',
                        recommendation: 'No recommendation.',
                        score: 95,
                        color: Colors.green,
                      ).animate().fadeIn(delay: 1800.ms, duration: 500.ms),
                      const SizedBox(height: 12),
                      _buildHistoryCard(
                        date: 'SEP\n11',
                        mood: 'Very Happy',
                        recommendation: 'Keep it Up!',
                        score: 65,
                        color: const Color(0xFF8B7355),
                      ).animate().fadeIn(delay: 2000.ms, duration: 500.ms),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard({
    required String date,
    required String mood,
    required String recommendation,
    required int score,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Date Column
          Column(
            children: [
              ...date.split('\n').map(
                    (text) => Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A3434),
                      ),
                    ),
                  ),
            ],
          ),
          const SizedBox(width: 16),
          // Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mood,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A3434),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  recommendation,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Score Circle
          CircularPercentIndicator(
            radius: 20,
            lineWidth: 3,
            percent: score / 100,
            center: Text(
              '$score',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            progressColor: color,
            backgroundColor: Colors.grey[200]!,
          ),
        ],
      ),
    );
  }
}

class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw curved lines pattern
    for (var i = 0; i < 10; i++) {
      final path = Path();
      path.moveTo(0, size.height * (i / 10));
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height * ((i + 1) / 10),
        size.width,
        size.height * (i / 10),
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}