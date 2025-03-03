// Updated AppColors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Main Colors
  static const Color primary = Color(0xFFDFE4EA);
  static const Color background = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF2F3542);
  static const Color lightBlue = Color(0xFFD3F1F7); 
  static const Color mediumBlue = Color(0xFF7DCCE0); // For gradient
  static const Color darkBlue = Color(0xFF307B95);

  // Smooth Background Gradient (similar to the mindfulness app)
  static final List<Color> backgroundGradient = [
    primary,
    background,
    background,
    background,
    primary,
  ];

  // Helper method to get gradient with improved smoothness
  static LinearGradient getBackgroundGradient({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: backgroundGradient,
      stops: const [0.0, 0.3, 0.5, 0.7, 1.0], // Adding stops for smoother transition
    );
  }

  // Primary Gradients - updated for smoother transition
  static final List<Color> primaryGradient = [
    background,
    const Color(0xFFEAF9FC),
    mediumBlue.withOpacity(0.2),
    mediumBlue.withOpacity(0.3),
    lightBlue.withOpacity(0.5),
  ];

  // Helper method to get primary gradient
  static LinearGradient getPrimaryGradient({
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: primaryGradient,
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0], // Adding stops for smoother transition
    );
  }
  
  // Card Gradient for UI elements
  static LinearGradient getCardGradient({
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: [
        lightBlue.withOpacity(0.8),
        lightBlue.withOpacity(0.6),
      ],
      stops: const [0.0, 1.0],
    );
  }
}



