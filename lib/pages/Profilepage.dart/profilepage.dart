import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lafia/routes/approutes.dart';
import 'package:lafia/utils/apptext.dart';
import 'package:lafia/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = false;

  Widget _buildProfileItem({
    required String title,
    required String assetImage,
    String? trailing,
    bool isSwitch = false,
    bool isDanger = false,
    VoidCallback? onTap,
  }) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 72,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isDanger ? AppColors.gray200 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDanger
                  ? AppColors.brown200
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              assetImage,
              width: 44,
              height: 44,
              
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isDanger ? AppColors.brown100 : AppColors.brown400,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: isSwitch
              ? Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                  activeColor: Colors.green,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (trailing != null)
                      Text(
                        trailing,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'lib/assets/Images/profileIcons/Monotone add.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'lib/assets/Images/profileIcons/backicons.png',
            width: 44,
            height: 44,
          ),
          onPressed: () {
            Get.toNamed(TRoutes.HomeScreen);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyles.heading2xlSemiBold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('lib/assets/Images/Ellipse 1.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Jean DOTY!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'elementary221b@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.brown300,
                    ),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // General Settings Section
            const Text(
              'General Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileItem(
              title: 'Notifications',
              assetImage: 'lib/assets/Images/profileIcons/notification.png',
              onTap: () {},
            ),
            _buildProfileItem(
              title: 'Personal Information',
              assetImage: 'lib/assets/Images/profileIcons/userk.png',
              onTap: () {},
            ),
            _buildProfileItem(
              title: 'Emergency Contact',
              assetImage: 'lib/assets/Images/profileIcons/emergency.png',
              trailing: '15+',
              onTap: () {},
            ),
            _buildProfileItem(
              title: 'Language',
              assetImage: 'lib/assets/Images/profileIcons/language.png',
              trailing: 'English (EN)',
              onTap: () {},
            ),
            _buildProfileItem(
              title: 'Dark Mode',
              assetImage: 'lib/assets/Images/profileIcons/dark.png',
              isSwitch: true,
              onTap: () {},
            ),
            _buildProfileItem(
              title: 'Invite Friends',
              assetImage: 'lib/assets/Images/profileIcons/invitedd.png',
              onTap: () {},
            ),
            _buildProfileItem(
              title: 'Submit Feedback',
              assetImage: 'lib/assets/Images/profileIcons/submit feedback.png',
              onTap: () {},
            ),

            const SizedBox(height: 32),

            // Security & Privacy Section
            const Text(
              'Security & Privacy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileItem(
              title: 'Security',
              assetImage: 'lib/assets/Images/profileIcons/sercurity.png',
              onTap: () {},
            ),
            _buildProfileItem(
              title: 'Help Center',
              assetImage: 'lib/assets/Images/profileIcons/mabj.png',
              onTap: () {},
            ),

            const SizedBox(height: 32),

            // Danger Zone Section
            const Text(
              'Danger Zone',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileItem(
              title: 'Close Account',
              assetImage: 'lib/assets/Images/profileIcons/deleted.png',
              isDanger: true,
              onTap: () {},
            ),

            const SizedBox(height: 32),

            // Log Out Section
            const Text(
              'Log Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileItem(
              title: 'Log Out',
              assetImage: 'lib/assets/Images/profileIcons/logout out.png',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
