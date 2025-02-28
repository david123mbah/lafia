import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lafia/routes/approutes.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Image.asset(
                          'lib/assets/Images/profileIcons/backicons.png',
                          width: 44,
                          height: 44,
                        ),
                        onPressed: () {
                          Get.toNamed(TRoutes.HomeScreen);
                        },
                      ),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE8E8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '+11',
                      style: TextStyle(
                        color: Color(0xFFFF5757),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Earlier This Day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                color: const Color(0xFF90A955),
                icon: Icons.message_outlined,
                title: 'Message from Dr Freud AI!',
                subtitle: '52 Total Unread Messages ⚡',
              ),
              _buildNotificationItem(
                color: const Color(0xFF8B7FF9),
                icon: Icons.edit_note,
                title: 'Journal Incomplete!',
                subtitle: "It's Reflection Time! ⚡",
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('8/32'),
                ),
              ),
              _buildNotificationItem(
                color: const Color(0xFF8B6D5C),
                icon: Icons.fitness_center,
                title: 'Exercise Complete!',
                subtitle: '22m Breathing Done. ⚡',
                showCheckmark: true,
              ),
              _buildNotificationItem(
                color: const Color(0xFFFFB347),
                icon: Icons.bar_chart,
                title: 'Mental Health Data is Here.',
                subtitle: 'Your Monthly Mental Analysis is here.',
                hasDownload: true,
              ),
              _buildNotificationItem(
                color: const Color(0xFF90A955),
                icon: Icons.sentiment_satisfied_alt,
                title: 'Mood Improved.',
                subtitle: 'Neutral → Happy',
                showCheckmark: true,
              ),
              const SizedBox(height: 24),
              const Text(
                'Last Week',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                color: const Color(0xFFFF7F50),
                icon: Icons.trending_down,
                title: 'Stress Decreased.',
                subtitle: 'Stress Level is now 3.',
                showProgressBar: true,
              ),
              _buildNotificationItem(
                color: const Color(0xFF8B6D5C),
                icon: Icons.health_and_safety,
                title: 'Dr Freud Recommendations.',
                subtitle: '48 Health Recommendations',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    bool showCheckmark = false,
    bool hasDownload = false,
    bool showProgressBar = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 4),
                if (hasDownload)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download, size: 16),
                        SizedBox(width: 4),
                        Text('Shinomiya Data.pdf'),
                      ],
                    ),
                  )
                else if (showProgressBar)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  )
                else
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null) trailing,
          if (showCheckmark)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }
}
