import 'package:flutter/material.dart';
import 'package:lafia/screens/auth/login_or_register.dart';
import 'package:lafia/widgets/custom_button.dart';
import 'package:lafia/widgets/custom_textfield.dart';
import 'package:lafia/utils/colors.dart'; // Ensure you import the colors if needed

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFA4B794) // Use the appropriate color
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
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 246, 241), // Match the background color
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
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
                          color: AppColors.brown300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                          prefixIcon: Icons.lock_clock_outlined,
                          suffixIcon: Icons.visibility,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Sign-Up",
                      onTap: () {
                        // Handle registration logic
                      },
                    ),
                    const SizedBox(height: 26),
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
                    const SizedBox(height: 30),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginOrRegister(),
                            ),
                          );
                        },
                        child: const Text(
                          "Already have an account? Sign In",
                          style: TextStyle(
                            color: AppColors.brown400,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
