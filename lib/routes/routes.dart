
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lafia/pages/Welcome&%20Onboarding_Screen/getstarted_screen.dart';
import 'package:lafia/pages/home/homepage.dart';
import 'package:lafia/routes/approutes.dart';
import 'package:lafia/routes/routeMiddleware.dart';


class TAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.getstarted, page: () => const GetstartedScreen()),
        GetPage(name: '/homeScreen', page: () => const HomeScreen())
  ];
}
