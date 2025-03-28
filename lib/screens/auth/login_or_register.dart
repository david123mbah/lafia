
import 'package:flutter/material.dart';
import 'package:lafia/screens/login_page.dart';
import 'package:lafia/screens/registration_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  // initilise show loginpage

bool showLoginPage = true;


// toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return Registerpage(onTap: togglePages);
    }
  }
}