import 'package:flutter/material.dart';
import 'package:lafia/utils/colors.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Text("Visits"),
    );
  }
}
