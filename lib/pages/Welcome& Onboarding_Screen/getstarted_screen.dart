import 'package:flutter/material.dart';
import 'package:lafia/pages/Welcome&%20Onboarding_Screen/first_onboardview.dart';
import 'package:lafia/pages/Welcome&%20Onboarding_Screen/onboarding.dart';
import 'package:lafia/screens/auth/login_or_register.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:lafia/screens/bottomnav/Bottom_Navigator.dart';
import 'package:lafia/utils/apptext.dart';
import 'package:lafia/utils/colors.dart';
import 'package:lafia/widgets/custom_button.dart';

class GetstartedScreen extends StatefulWidget {
  const GetstartedScreen({super.key});

  @override
  State<GetstartedScreen> createState() => _GetstartedScreenState();
}

class _GetstartedScreenState extends State<GetstartedScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 246, 241),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Welcome to  Freemid !',
                  style: TextStyles.heading2xlBold
                      .copyWith(color: AppColors.brown400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your mindful mental health AI companion for everyone, anywhere 🌱',
                  style: TextStyles.paragraphLg,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("lib/assets/Images/babybodd.png"))),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () {
                    // Handle navigation here
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Onboarding()),
                    );
                  },
                  text: 'Get Started ',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyles.textMdBold
                          .copyWith(color: AppColors.brown400),
                    ),
                    GestureDetector(
                      onTap: () {
                         // Handle navigation here
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigator()),
                    );
                      },
                      child: Text(
                        'Sign In.',
                        style: TextStyles.textMdBold
                            .copyWith(color: AppColors.orange200),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
