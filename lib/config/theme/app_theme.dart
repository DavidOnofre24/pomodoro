import 'package:flutter/material.dart';
import 'package:pomodoro/config/constants/colors.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: CustomColors.pink,
          brightness: Brightness.dark,
          backgroundColor: Colors.black.withOpacity(0.1),
        ),
      );
}
