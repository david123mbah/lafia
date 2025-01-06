import 'package:flutter/material.dart';
import 'package:lafia/pages/Welcome&%20Onboarding_Screen/getstarted_screen.dart';
import 'package:lafia/pages/home/homepage.dart';
import 'package:lafia/screens/bottomnav/Bottom_Navigator.dart';
import 'package:lafia/utils/apptext.dart';
import 'package:lafia/utils/colors.dart';
import 'package:lafia/widgets/custom_button.dart';
import 'package:lafia/widgets/custom_textfield.dart';

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFA4B794)
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
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 246, 241),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 200,
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
                        'lib/assets/Images/Solid menu.png',
                        height: 65,
                        width: 65,
                      ),
                    ),
                  ],
                ),
              ),
              // Rest of your code remains the same...
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
                    ),
                    const SizedBox(height: 40),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " Email Address ",
                          style: TextStyle(
                            color: AppColors.brown400,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyTextfield(
                          controller: _emailController,
                          hintText: "Email",
                          obscureText: false,
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          " Password ",
                          style: TextStyle(
                            color: AppColors.brown400,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyTextfield(
                          controller: _passwordController,
                          hintText: "Password",
                          obscureText: true,
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.visibility,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      text: "Sign-In",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigator()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
                        const SizedBox(width: 40),
                        GestureDetector(
                          onTap: () {
                            // Handle Google login
                          },
                          child: Image.asset(
                            'lib/assets/Images/Framell.png',
                            height: 55,
                            width: 55,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
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
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: AppColors.orange300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
