import 'package:flutter/material.dart';
import 'package:lafia/pages/AIchartboard/chartscreen.dart';
import 'package:lafia/widgets/custom_button.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _fadeIn();
  }

  void _fadeIn() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: Column(
          children: [
            // Top section with background image and stats
            SizedBox(
              height: 480,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.asset(
                        'lib/assets/Images/emotions/animes.png', // Make sure to add this image to your assets
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Content overlay
                  SafeArea(
                    child: Column(
                      children: [
                        // App bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Center(
                                child: Text(
                                  'My Conversations',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B9D83),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'BASIC',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Large number
                        const SizedBox(height: 40),
                        const Text(
                          '1571',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Total Conversations',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        // Stats row
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '32',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Left this month',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.show_chart,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  'Slow',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Response & Support',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Bottom action buttons
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ActionButton(
                              color: const Color(0xFFFF7F50),
                              icon: Icons.analytics,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 46),
                            _ActionButton(
                              color: Colors.white,
                              icon: Icons.add,
                              size: 75,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChartScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 46),
                            _ActionButton(
                              color: const Color(0xFF8B9D83),
                              icon: Icons.settings,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Updated Upgrade card with precise design match
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4ED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      // Left side with AI character
                      Container(
                        width: 120,
                        child: Image.asset(
                          'lib/assets/Images/emotions/bmcm.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Right side content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Upgrade to Pro!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF59473E),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Support item
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF59473E),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '24/7 Live & Fast Support',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF59473E),
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Conversations item
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF59473E),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Unlimited Conversations!!',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF59473E),
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Go Pro button
                            Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF59473E),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Center(
                                child: Text(
                                  'Go Pro, Now!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const _ActionButton({
    required this.color,
    required this.icon,
    required this.onPressed,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon,
            color: color == Colors.white ? Colors.black : Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
