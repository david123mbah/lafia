import 'package:flutter/material.dart';
import 'package:lafia/utils/colors.dart';

class DoctorsListPage extends StatelessWidget {
  const DoctorsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Text("Doctors"),
    );
  }
}

   