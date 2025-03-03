import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lafia/pages/Doctors/appointments_page.dart';
import 'package:lafia/pages/Doctors/doctors_list_page.dart';
import 'package:lafia/utils/colors.dart';

class ChatDoctor extends StatefulWidget {
  const ChatDoctor({super.key});

  @override
  State<ChatDoctor> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatDoctor> {
  int selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.getBackgroundGradient(),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Browse All Doctors',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Tab control with exact dimensions and styling
                Container(
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedSegment = 0),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: selectedSegment == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'Doctors',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: selectedSegment == 0
                                      ? AppColors.secondary
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedSegment = 1),
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: selectedSegment == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                'Appiontment',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: selectedSegment == 1
                                      ? AppColors.secondary
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add content container below if needed
                // This could be conditionally displayed based on selectedSegment
                const SizedBox(height: 5),
                Expanded(
                  child: selectedSegment == 0
                      ? const DoctorsListPage()
                      : const AppointmentsPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
