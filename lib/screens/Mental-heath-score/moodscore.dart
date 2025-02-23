import 'package:flutter/material.dart';

class MindFullHours extends StatefulWidget {
  const MindFullHours({super.key});

  @override
  State<MindFullHours> createState() => _MindFullHoursState();
}

class _MindFullHoursState extends State<MindFullHours> {
  String selectedFilter = 'ALL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0), // Background color
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: CustomPaint(
                painter: MindfulHoursPainter(),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            // Top Bar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back Button
                                IconButton(
                                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                // Title
                                const Text(
                                  'Mindful Hours',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Placeholder for alignment
                                const SizedBox(width: 48),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Total Duration
                            const Text(
                              '5.21h',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Total Duration',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Time Filters
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = 'ALL';
                                    });
                                  },
                                  child: Text(
                                    'ALL',
                                    style: TextStyle(
                                      color: selectedFilter == 'ALL' ? Colors.blue : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = 'MORNING';
                                    });
                                  },
                                  child: Text(
                                    'MORNING',
                                    style: TextStyle(
                                      color: selectedFilter == 'MORNING' ? Colors.blue : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = 'EVENING';
                                    });
                                  },
                                  child: Text(
                                    'EVENING',
                                    style: TextStyle(
                                      color: selectedFilter == 'EVENING' ? Colors.blue : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFilter = 'AFTERNOON';
                                    });
                                  },
                                  child: Text(
                                    'AFTERNOON',
                                    style: TextStyle(
                                      color: selectedFilter == 'AFTERNOON' ? Colors.blue : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Mindful Hour History
                            Expanded(
                              child: ListView(
                                children: const [
                                  MindfulHourHistoryItem(
                                    title: 'Deep Meditation',
                                    subtitle: 'NATURE',
                                    duration: '25:00',
                                  ),
                                  MindfulHourHistoryItem(
                                    title: 'Delayed State',
                                    subtitle: 'CHIRPING BIRD',
                                    duration: '25:00',
                                  ),
                                  MindfulHourHistoryItem(
                                    title: 'Deep Meditation',
                                    subtitle: 'NATURE',
                                    duration: '25:00',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MindfulHourHistoryItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;

  const MindfulHourHistoryItem({
    required this.title,
    required this.subtitle,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
        trailing: Text(duration, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class MindfulHoursPainter extends CustomPainter {
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
        size.width * 0.25,
        size.height * ((i + 1) / 10) - 20,
        size.width * 0.5,
        size.height * (i / 10),
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        size.height * ((i + 1) / 10) + 20,
        size.width,
        size.height * (i / 10),
      );
      canvas.drawPath(path, paint);
    }

    // Draw circles
    for (var i = 0; i < 5; i++) {
      final offset = Offset(size.width * (i / 5), size.height * (i / 5));
      canvas.drawCircle(offset, 20, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}