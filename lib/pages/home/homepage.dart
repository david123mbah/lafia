import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lafia/utils/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MindfulnessCardPainter extends CustomPainter {
  final double cornerRadius;

  MindfulnessCardPainter({this.cornerRadius = 16.0});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.lightBlue.withOpacity(0.8),
          AppColors.lightBlue.withOpacity(0.6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Draw rounded rectangle for card
    final RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(cornerRadius),
    );

    canvas.drawRRect(roundedRect, paint);

    // Add subtle highlight on top edge
    final Paint highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Path highlightPath = Path()
      ..moveTo(cornerRadius, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..arcToPoint(
        Offset(size.width, cornerRadius),
        radius: Radius.circular(cornerRadius),
      );

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _mindfulnessCards = [
    {'title': 'Meditate', 'icon': Icons.self_improvement},
    {'title': 'Sleep', 'icon': Icons.bedtime},
    {'title': 'Breath', 'icon': Icons.air},
    {'title': 'Affirmate', 'icon': Icons.spa},
  ];

  late AnimationController _headerController;
  late AnimationController _searchController;
  late AnimationController _gridController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _searchController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Staggered animation sequence
    Future.delayed(const Duration(milliseconds: 100), () {
      _headerController.forward();
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      _searchController.forward();
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      _gridController.forward();
    });

    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _searchController.dispose();
    _gridController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.getBackgroundGradient(),
        ),
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Welcome Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo and brand
                      FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _headerController,
                          curve:
                              const Interval(0.0, 0.5, curve: Curves.easeOut),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.5),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _headerController,
                            curve:
                                const Interval(0.0, 0.5, curve: Curves.easeOut),
                          )),
                          child: Row(
                            children: [
                              Image.asset(
                                'lib/assets/Images/Freemindm.png',
                                height: 30,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'FREEMIND',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Welcome text
                      FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _headerController,
                          curve:
                              const Interval(0.3, 0.8, curve: Curves.easeOut),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _headerController,
                            curve:
                                const Interval(0.3, 0.8, curve: Curves.easeOut),
                          )),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Morning, Jean!',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Start your mindfulness journey',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF5A5A5A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Search bar
                      FadeTransition(
                        opacity: _searchController,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(_searchController),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.search,
                                  color: Colors.grey.shade400,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Search mindfulness exercises',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Mindfulness Cards Grid - Staggered Animation
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _gridController,
                          curve: Interval(
                            (index * 0.2).clamp(0.0, 1.0),
                            min((index * 0.2 + 0.2), 1.0),
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _gridController,
                            curve: Interval(
                              (index * 0.2).clamp(0.0, 1.0),
                              min((index * 0.2 + 0.2), 1.0),
                              curve: Curves.easeOut,
                            ),
                          )),
                          child: _buildMindfulnessCard(
                            _mindfulnessCards[index]['title'],
                            _mindfulnessCards[index]['icon'],
                          ),
                        ),
                      );
                    },
                    childCount: _mindfulnessCards.length,
                  ),
                ),
              ),

              // Additional space at bottom
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMindfulnessCard(String title, IconData iconData) {
    return CustomPaint(
      painter: MindfulnessCardPainter(),
      child: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    iconData,
                    color: AppColors.darkBlue.withOpacity(0.3),
                    size: 36,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Play button
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
