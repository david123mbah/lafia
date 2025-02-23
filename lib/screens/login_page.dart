import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafia/routes/approutes.dart';
import 'package:lafia/utils/apptext.dart';
import 'package:lafia/utils/colors.dart';
import 'package:lafia/widgets/custom_button.dart';
import 'package:lafia/widgets/custom_textfield.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth/authservices.dart';

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFF50E3C2)
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

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String _message = '';
  bool _emailError = false;
  bool _passwordError = false;

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _toggleLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _signInWithEmail() async {
    _toggleLoading(true);
    setState(() {
      _emailError = false;
      _passwordError = false;
    });
    try {
      User? user = await _authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        Get.toNamed(TRoutes.BottomNav);
      }
    } catch (e) {
      _showMessage(e.toString());
      if (e.toString().contains('email')) {
        setState(() {
          _emailError = true;
        });
      }
      if (e.toString().contains('password')) {
        setState(() {
          _passwordError = true;
        });
      }
    } finally {
      _toggleLoading(false);
    }
  }

  Future<void> _signInWithGoogle() async {
    _toggleLoading(true);
    try {
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        Get.toNamed(TRoutes.BottomNav);
      }
    } catch (e) {
      _showMessage(e.toString());
    } finally {
      _toggleLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 246, 241),
      body: SingleChildScrollView(
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
                    ).animate().fadeIn(duration: 800.ms),
                   
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Sign In to lafia.ai',
                      style: TextStyles.heading2xlBold.copyWith(
                        fontSize: 28,
                        color: AppColors.brown300,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 500.ms, duration: 800.ms),
                    const SizedBox(height: 40),
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
                        ).animate().fadeIn(delay: 700.ms, duration: 800.ms),
                        MyTextfield(
                          controller: _emailController,
                          hintText: "Email",
                          obscureText: false,
                          prefixIcon: Icons.email,
                          errorText: _emailError ? 'Invalid email' : null,
                        ).animate().fadeIn(delay: 800.ms, duration: 800.ms),
                        const SizedBox(height: 30),
                        const Text(
                          " Password ",
                          style: TextStyle(
                            color: AppColors.brown100,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fadeIn(delay: 900.ms, duration: 800.ms),
                        MyTextfield(
                          controller: _passwordController,
                          hintText: "Password",
                          obscureText: true,
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.visibility,
                          errorText: _passwordError ? 'Invalid password' : null,
                        ).animate().fadeIn(delay: 1000.ms, duration: 800.ms),
                      ],
                    ),
                    const SizedBox(height: 40),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      CustomButton(
                        text: "Sign-In",
                        onTap: _signInWithEmail,
                      ).animate().fadeIn(delay: 1100.ms, duration: 800.ms),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _signInWithGoogle,
                          child: Image.asset(
                            'lib/assets/Images/Framehh.png',
                            height: 55,
                            width: 55,
                          ).animate().fadeIn(delay: 1200.ms, duration: 800.ms),
                        ),
                        const SizedBox(width: 40),
                        GestureDetector(
                          onTap: () {
                            // Handle Facebook login
                          },
                          child: Image.asset(
                            'lib/assets/Images/Framell.png',
                            height: 55,
                            width: 55,
                          ).animate().fadeIn(delay: 1300.ms, duration: 800.ms),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    if (_message.isNotEmpty)
                      Text(
                        _message,
                        style: const TextStyle(color: Colors.red),
                      ).animate().fadeIn(delay: 1400.ms, duration: 800.ms),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an Account? ",
                            style: TextStyle(
                              color: AppColors.brown400,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn(delay: 1400.ms, duration: 800.ms),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: AppColors.brown200,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 1500.ms, duration: 800.ms),
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
  }
}
