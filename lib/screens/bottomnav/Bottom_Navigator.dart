import 'package:flutter/material.dart';
import 'package:lafia/pages/AIchartboard/chartpage.dart';
import 'package:lafia/pages/Doctors/doctordetailpage.dart';
import 'package:lafia/pages/Profilepage.dart/profilepage.dart';
import 'package:lafia/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:lafia/Controller/main_screen.provider.dart';
import 'package:lafia/pages/home/homepage.dart';
import 'dart:math';

const double buttonSize = 65.0;
const double startAngle = -pi / 2;
const double spanAngle = pi;

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator>
    with SingleTickerProviderStateMixin {
  // List of icon paths for navigation icons
  final List<String> iconPaths = [
    "lib/assets/Images/mindicons/Homew.png",
    "lib/assets/Images/20  chat.png",
    "lib/assets/Images/mindicons/Calendar.png",
    "lib/assets/Images/13  user.png",
  ];

  late AnimationController _animationController;
  bool _isRadialMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleRadialMenu() {
    if (_isRadialMenuOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    _isRadialMenuOpen = !_isRadialMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    // List of pages corresponding to each navigation item
    List<Widget> pageList = [
      const HomeScreen(),
      const ChartPage(),
      const ChatDoctor(),
      const ProfilePage(),
    ];

    return Consumer<MainScreenNotifer>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: Colors.transparent, // Changed to transparent
          extendBody:
              true, // Add this to allow content to flow behind the bottom nav
          // Display the current page based on the index
          body: pageList[mainScreenNotifier.pageIndex],
          // Floating action button centered in the bottom navigation bar
          floatingActionButton: Stack(
            children: [
              // Radial Menu Items
              RadialMenuItem(
                animation: _animationController,
                index: 0,
                icon: Icons.people,
                color: AppColors.secondary,
                onPressed: () {
                  // Handle Community action
                  _toggleRadialMenu();
                },
              ),
              RadialMenuItem(
                animation: _animationController,
                index: 1,
                icon: Icons.chat_bubble,
                color: AppColors.secondary,
                onPressed: () {
                  // Handle AI Chat action
                  _toggleRadialMenu();
                },
              ),
              RadialMenuItem(
                animation: _animationController,
                index: 2,
                icon: Icons.share,
                color: AppColors.secondary,
                onPressed: () {
                  // Handle Share action
                  _toggleRadialMenu();
                },
              ),
              // Main FAB
              Container(
                width: buttonSize,
                height: buttonSize,
                margin: const EdgeInsets.only(top: 30),
                child: FloatingActionButton(
                  backgroundColor: AppColors.secondary,
                  onPressed: _toggleRadialMenu,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    color: AppColors.background,
                    progress: _animationController,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
            child: CustomBottomNavBar(
              selectedIndex: mainScreenNotifier.pageIndex,
              onTap: (index) => mainScreenNotifier.pageIndex = index,
              iconPaths: iconPaths,
            ),
          ),
        );
      },
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<String> iconPaths;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.iconPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.9), // Made slightly transparent
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // Reduced shadow opacity
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03), // Reduced shadow opacity
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(iconPaths.length + 1, (index) {
          if (index == iconPaths.length ~/ 2) {
            return const SizedBox(width: 65);
          }
          final iconIndex = index > iconPaths.length ~/ 2 ? index - 1 : index;
          return NavItem(
            iconPath: iconPaths[iconIndex],
            isActive: selectedIndex == iconIndex,
            onTap: () => onTap(iconIndex),
          );
        }),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.background
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          iconPath,
          width: 26,
          height: 26,
          color: isActive ? AppColors.secondary : const Color(0xFF9E9E9E),
        ),
      ),
    );
  }
}

class RadialMenuItem extends StatelessWidget {
  final AnimationController animation;
  final int index;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const RadialMenuItem({
    super.key,
    required this.animation,
    required this.index,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Increased spacing by adjusting the angle calculations
    const double baseAngle = 120.0; // Increased from 90.0
    final num rad = radians(baseAngle / 4 * (index + 1));
    const double distance = buttonSize + 45.0; // Increased distance from center

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              distance * animation.value * cos(rad),
              -distance * animation.value * sin(rad),
            ),
          child: Transform.rotate(
            angle: (1.0 - animation.value) * pi / 2,
            child: Opacity(
              opacity: animation.value,
              child: Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(icon, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
