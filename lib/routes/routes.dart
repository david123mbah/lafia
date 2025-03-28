
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafia/pages/AIchartboard/chartscreen.dart';
import 'package:lafia/pages/AIchartboard/conversation.dart';
import 'package:lafia/pages/Welcome&%20Onboarding_Screen/getstarted_screen.dart';
import 'package:lafia/pages/home/homepage.dart';
import 'package:lafia/routes/approutes.dart';
import 'package:lafia/routes/routeMiddleware.dart';
import 'package:lafia/screens/bottomnav/Bottom_Navigator.dart';


class TAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.getstarted, page: () => const GetstartedScreen()),
        GetPage(name:  TRoutes.HomeScreen, page: () => const HomeScreen()),
         GetPage(name:  TRoutes.BottomNav, page: () => const BottomNavigator()),
          GetPage(name:  TRoutes.chatbot, page: () => const ConversationsScreen(userId: '',))
  ];
}
