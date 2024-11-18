import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      titleTextStyle: TextStyle(color: AppColors.dark, fontSize: 20),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.dark),
      bodyMedium: TextStyle(color: AppColors.secondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent, // Sets the background color
        foregroundColor: AppColors.primaryBackground, // Sets the text/icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Example: rounded corners
        ),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.dark),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.dark,
    scaffoldBackgroundColor: AppColors.accent,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark,
      titleTextStyle: TextStyle(color: AppColors.primaryBackground, fontSize: 20),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryBackground),
      bodyMedium: TextStyle(color: AppColors.secondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.primaryBackground),
  );
}
