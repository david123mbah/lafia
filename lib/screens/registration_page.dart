import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lafia/pages/Welcome&%20Onboarding_Screen/first_onboardview.dart';
import 'package:lafia/screens/auth/authservices.dart';
import 'package:lafia/screens/auth/login_or_register.dart';
import 'package:lafia/widgets/custom_button.dart';
import 'package:lafia/widgets/custom_textfield.dart';
import 'package:lafia/utils/colors.dart'; // Ensure you import the colors if needed
import 'package:flutter/scheduler.dart' show timeDilation; // Import AuthService

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFF50E3C2) // Use the appropriate color
      ..style = PaintingStyle.fill;

    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Registerpage extends StatefulWidget {
  final void Function()? onTap;
  const Registerpage({super.key, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _agreeToTerms = false;
  bool _emailError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  String _message = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final AuthService _authService = AuthService(); // Initialize AuthService

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

  // Method to handle registration
  void _register() async {
    setState(() {
      _emailError = false;
      _passwordError = false;
      _confirmPasswordError = false;
      _message = '';
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _confirmPasswordError = true;
        _message = 'Passwords do not match';
      });
      return;
    }

    try {
      User? user = await _authService.registerWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Container(
            padding: const EdgeInsets.all(16.0),
            margin:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.green.shade50, // Light green background
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.green.shade400),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Registration successful!',
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )),
        );

        // Navigate to OnboardingScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    } catch (e) {
      // Show error message
      setState(() {
        _message = e.toString();
        if (e.toString().contains('email')) {
          _emailError = true;
        }
        if (e.toString().contains('password')) {
          _passwordError = true;
        }
      });
    }
  }

  // Method to handle Google sign-in
  void _signInWithGoogle() async {
    try {
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.green.shade50, // Light green background
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.green.shade400),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Google sign-in successful!',
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
        // Navigate to another page or perform other actions
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 247, 246, 241), // Match the background color
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 400),
                        painter: CurvedPainter(),
                      ),
                      Positioned(
                        top: 80,
                        left: 20,
                        right: 50,
                        child: Image.asset(
                          'lib/assets/Images/Solid menu.png', // Adjust the image path
                          height: 65,
                          width: 65,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text(
                          'Sign Up for Free',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brown100,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            " Email Address ",
                            style: TextStyle(
                              color: AppColors.brown100,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyTextfield(
                            controller: _emailController,
                            hintText: "Email",
                            obscureText: false,
                            prefixIcon: Icons.email,
                            errorText: _emailError ? 'Invalid email' : null,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            " Password ",
                            style: TextStyle(
                              color: AppColors.brown200,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyTextfield(
                            controller: _passwordController,
                            hintText: "Password",
                            obscureText: true,
                            prefixIcon: Icons.lock_clock_outlined,
                            suffixIcon: Icons.visibility,
                            errorText:
                                _passwordError ? 'Invalid password' : null,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            " Confirm Password ",
                            style: TextStyle(
                              color: AppColors.brown200,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyTextfield(
                            controller: _confirmPasswordController,
                            hintText: "Confirm Password",
                            obscureText: true,
                            prefixIcon: Icons.lock_clock_outlined,
                            suffixIcon: Icons.visibility,
                            errorText: _confirmPasswordError
                                ? 'Passwords do not match'
                                : null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                _agreeToTerms = value!;
                              });
                            },
                          ),
                          const Text(
                            "I Agree with the Terms & Conditions",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.brown100,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: "Sign-Up",
                        onTap: _register, // Use the _register method
                      ),
                      const SizedBox(height: 26),
                      if (_message.isNotEmpty)
                        Text(
                          _message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle Facebook login
                            },
                            child: Image.asset(
                              'lib/assets/Images/Framehh.png',
                              height: 55,
                              width: 55,
                            ),
                          ),
                          const SizedBox(width: 40),
                          GestureDetector(
                            onTap:
                                _signInWithGoogle, // Use the _signInWithGoogle method
                            child: Image.asset(
                              'lib/assets/Images/Framell.png',
                              height: 55,
                              width: 55,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: GestureDetector(
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: AppColors.brown400,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " Sign In",
                                style: TextStyle(
                                  color: AppColors.brown200,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
