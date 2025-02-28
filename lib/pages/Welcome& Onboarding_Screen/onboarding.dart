import 'package:flutter/material.dart';
import 'package:lafia/screens/auth/login_or_register.dart';
import 'package:lafia/utils/colors.dart';
import 'package:lafia/widgets/custom_button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "lib/assets/Images/mindicons/cbbcb.png",
      "title": "Personalize Your Mental",
      "subtitle": "Tailored experiences for your unique mental journey"
    },
    {
      "image": "lib/assets/Images/mindicons/vvfjv.png",
      "title": "Intelligent Mood Tracking",
      "subtitle": "Smart insights into your emotional patterns"
    },
    {
      "image": "lib/assets/Images/cjvjvj.png",
      "title": "Mindful Resources That",
      "subtitle": "Curated content for your mental wellbeing"
    },
    {
      "image": "lib/assets/Images/dfggsf.png",
      "title": "Talk to  your AI Doctor",
      "subtitle": "A compassionate community that cares"
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      // Navigate to next screen
      // Handle navigation here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginOrRegister()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() => _currentPage = page);
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 300),
                      painter: WavePainter(),
                      child: Container(
                        height: 400,
                        alignment: Alignment.center,
                        child: Image.asset(
                          onboardingData[index]['image']!,
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: [
                          Text(
                            onboardingData[index]['title']!,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.brown300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            onboardingData[index]['subtitle']!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.brown100,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? AppColors.brown400
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FloatingActionButton(
                  onPressed: _nextPage,
                  backgroundColor: AppColors.brown400,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
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

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF7F6F1)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.9)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.7,
        size.width * 0.5,
        size.height * 0.8,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.9,
        size.width,
        size.height * 0.8,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
