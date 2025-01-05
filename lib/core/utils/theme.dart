import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/core/utils/app_colors.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.baseColor1,
        appBarTheme: AppBarTheme(
          centerTitle: true,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.baseColor1,
            )));
  }
}
