import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppFontWeight {

  static const regular = FontWeight.normal;
  static const bold= FontWeight.bold;
}

abstract class AppStyles {
  ThemeData? themeData;

  TextStyle? defaultTitleStyle();
  TextStyle? defaultTextStyle();
  TextStyle? defaultHeadlineStyle();
  Color? backgroundContainer();
  Color? itemContainer();
}

class DefaultAppStyles implements AppStyles {
  @override
  ThemeData? themeData = ThemeData(
    backgroundColor: AppColors.backgroundColor,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 55, height: 1),
      headline4: TextStyle(fontSize: 20, fontWeight: AppFontWeight.bold),
      bodyText1: TextStyle(fontSize: 14, fontWeight: AppFontWeight.regular),
      bodyText2: TextStyle(fontSize: 10, fontWeight: AppFontWeight.regular)
    ),
  );

  @override
  TextStyle? defaultTextStyle() {
    return themeData?.textTheme.bodyText1?.copyWith(color: Colors.white);
  }

  @override
  TextStyle? defaultHeadlineStyle() {
    return themeData?.textTheme.headline4?.copyWith( color: Colors.white);
  }

  @override
  TextStyle? defaultTitleStyle() {
    return themeData?.textTheme.headline1?.copyWith( color: Colors.white);
  }

  @override
  Color? backgroundContainer() {
    return AppColors.white;
  }

  @override
  Color? itemContainer() {
    return AppColors.backgroundColor;
  }
}

class BrightAppStyles implements AppStyles {
  @override
  ThemeData? themeData = ThemeData(
    backgroundColor: AppColors.white,
    textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 55, height: 1),
        headline4: TextStyle(fontSize: 20, fontWeight: AppFontWeight.bold),
        bodyText1: TextStyle(fontSize: 14, fontWeight: AppFontWeight.regular),
        bodyText2: TextStyle(fontSize: 10, fontWeight: AppFontWeight.regular)
    ),
  );

  @override
  TextStyle? defaultTextStyle() {
    return themeData?.textTheme.bodyText1?.copyWith(color: AppColors.backgroundColor);
  }

  @override
  TextStyle? defaultHeadlineStyle() {
    return themeData?.textTheme.headline4?.copyWith( color: AppColors.backgroundColor);
  }

  @override
  TextStyle? defaultTitleStyle() {
    return themeData?.textTheme.headline1?.copyWith( color: AppColors.backgroundColor);
  }

  @override
  Color? backgroundContainer() {
   return AppColors.backgroundColor;
  }

  @override
  Color? itemContainer() {
   return AppColors.white;
  }
}
