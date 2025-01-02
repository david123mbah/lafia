import 'package:flutter/material.dart';
import 'package:lafia/widgets/custom_progress.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 1;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'lib/assets/Images/hhhvfssvhkfhkvsf.png',
      title: 'Personalize Your Mental\nHealth State With AI',
      backgroundColor: const Color(0xFFF5F5F0),
      accentColor: const Color(0xFF8B9B7C),
      stepColor: const Color(0xFFE8EAE3),
    ),
    OnboardingContent(
      image: 'lib/assets/Images/jkklklkgdfb.png',
      title: 'Intelligent Mood Tracking\n& Emotion Insights',
      backgroundColor: const Color(0xFFFFF0EB),
      accentColor: const Color(0xFFFF6B4E),
      stepColor: const Color(0xFFFFE4DC),
    ),
    OnboardingContent(
      image: 'assets/mindful_resources.png',
      title: 'Mindful Resources That\nMakes You Happy',
      backgroundColor: const Color(0xFFFFF8E7),
      accentColor: const Color(0xFFFFC145),
      stepColor: const Color(0xFFFFF2D1),
    ),
    OnboardingContent(
      image: 'assets/community.png',
      title: 'Loving & Supportive\nCommunity',
      backgroundColor: const Color(0xFFF0EBFF),
      accentColor: const Color(0xFF8B6EFF),
      stepColor: const Color(0xFFE4DCFF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index + 1;
              });
            },
            itemCount: _contents.length,
            itemBuilder: (context, index) {
              return OnboardingPage(content: _contents[index], pageNumber: index + 1);
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CustomProgressIndicator(
                  current: _currentPage,
                  total: _contents.length,
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    if (_currentPage < _contents.length) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A332D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;
  final int pageNumber;

  const OnboardingPage({
    super.key,
    required this.content,
    required this.pageNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: content.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: content.stepColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'STEP $pageNumber',
                style: TextStyle(
                  color: const Color(0xFF4A332D),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                  children: _buildTitleSpans(content.title),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: CustomBackground(
                child: Image.asset(
                  content.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _buildTitleSpans(String title) {
    final words = title.split(' ');
    return words.map((word) {
      if (word.contains('AI') || 
          word.contains('Mindful') || 
          word.contains('Health') ||
          word.contains('Community')) {
        return TextSpan(
          text: '$word ',
          style: TextStyle(color: content.accentColor),
        );
      }
      return TextSpan(
        text: '$word ',
        style: const TextStyle(color: Color(0xFF4A332D)),
      );
    }).toList();
  }
}

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        color: Colors.white.withOpacity(0.1),
        child: child,
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, size.height * 0.3, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OnboardingContent {
  final String image;
  final String title;
  final Color backgroundColor;
  final Color accentColor;
  final Color stepColor;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.backgroundColor,
    required this.accentColor,
    required this.stepColor,
  });
}