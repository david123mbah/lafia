import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lafia/Controller/main_screen.provider.dart';
import 'package:lafia/pages/home/homepage.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  // List of icon paths for navigation icons
  final List<String> iconPaths = [
    "lib/assets/Images/10  home.png",
    "lib/assets/Images/20  chat.png",
    "lib/assets/Images/18  chart.png",
    "lib/assets/Images/13  user.png",
  ];

  @override
  Widget build(BuildContext context) {
    // List of pages corresponding to each navigation item
    List<Widget> pageList = const [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ];

    return Consumer<MainScreenNotifer>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFEAE7E1),
          // Display the current page based on the index
          body: pageList[mainScreenNotifier.pageIndex],
          // Floating action button centered in the bottom navigation bar
          floatingActionButton: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF8AAE76), // Green color for the FAB
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: const Color(0xFF8AAE76).withOpacity(0.3),
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // Custom bottom navigation bar
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: mainScreenNotifier.pageIndex,
            onTap: (index) => mainScreenNotifier.pageIndex = index,
            iconPaths: iconPaths,
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
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    required this.iconPaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Custom paint for the background shape of the navigation bar
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 90),
            painter: BottomNavPainter(),
          ),
          // Container holding the navigation items
          Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(iconPaths.length + 1, (index) {
                if (index == iconPaths.length ~/ 2) {
                  return const SizedBox(width: 70); // Space for the FAB
                }
                final iconIndex =
                    index > iconPaths.length ~/ 2 ? index - 1 : index;
                return NavItem(
                  iconPath: iconPaths[iconIndex],
                  isActive: selectedIndex == iconIndex,
                  onTap: () => onTap(iconIndex),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white // Background color of the navigation bar
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20),
      ));

    // Draw shadow for the navigation bar
    canvas.drawShadow(path, Colors.black.withOpacity(0.05), 10, true);
    // Draw the main shape
    canvas.drawPath(path, paint);

    // Border paint for the navigation bar
    Paint borderPaint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class NavItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    Key? key,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF5F5F5) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          iconPath,
          width: 48,
          height: 48,
          color: isActive ? const Color(0xFF8AAE76) : const Color(0xFFADADAD),
        ),
      ),
    );
  }
}