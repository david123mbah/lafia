import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String iconPath;
  final double iconSize;

  const BottomNavItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.iconPath,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Improves touch area
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
              color: isActive ? Colors.white : Colors.grey, // Active/inactive color
            ),
            const SizedBox(height: 4),
            if (isActive)
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}