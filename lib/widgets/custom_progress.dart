import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int current;
  final int total;

  const CustomProgressIndicator({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        if (index == current - 1) {
          // Active indicator
          return Container(
            width: 44,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        } else {
          // Inactive indicator
          return Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
          );
        }
      }),
    );
  }
}
