
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:lafia/routes/approutes.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('Middleware activated: checking authentication status...');

    // Simulate checking user authentication status (can be replaced with actual logic)
    const bool isAuthenticated = false;  // Replace this with actual authentication check

    // If the user is not authenticated, redirect them to the login route
    // ignore: dead_code
    return isAuthenticated ? null : const RouteSettings(name: TRoutes.getstarted);
  }
}
