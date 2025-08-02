

import 'package:flutter/material.dart';

/// A utility class that holds all the color constants for the app,
/// following a dark, modern theme.
///
/// This class is designed with a private constructor to prevent it from
/// being instantiated. All colors should be accessed via static members.
/// Example: `AppColors.brandPrimary`
class AppColors {
  // This class is not meant to be instantiated.
  const AppColors._();

  // --- BRAND COLORS ---
  /// The primary brand color, used for main actions, highlights, and pending status.
  static const Color brandPrimary = Color(0xFFFF6B35);

  /// A darker shade of the primary brand color, often used in gradients.
  static const Color brandDark = Color(0xFFE55A2B);

  // --- NEUTRAL COLORS ---
  /// The darkest background color, typically used for the main scaffold.
  static const Color neutralBlack = Color(0xFF0D1117);

  /// A dark color used for AppBars, bottom navigation, and secondary backgrounds.
  static const Color neutralDark = Color(0xFF161B22);

  /// The background color for cards, modals, and other elevated surfaces.
  static const Color neutralDarkGrey = Color(0xFF21262D);

  /// A light grey used for borders, dividers, and disabled elements.
  static const Color neutralLightGrey = Color(0xFF30363D);

  // --- STATUS COLORS ---
  /// Used for success indicators, confirmed statuses, and positive actions.
  static const Color statusSuccess = Color(0xFF238636);

  /// Used for informational messages and in-progress statuses.
  static const Color statusInfo = Color(0xFF0969DA);

  /// Used to indicate a completed or verified status.
  static const Color statusCompleted = Color(0xFF8B5CF6);

  /// Used for destructive actions, errors, and canceled statuses.
  static const Color statusError = Color(0xFFDA3633);

  // --- TEXT COLORS ---
  /// The primary color for main text elements like titles and body text.
  static const Color textPrimary = Colors.white;

  /// The secondary color for subtitles, hints, and less important text.
  static const Color textSecondary = Color(0xFF7D8590);
}