import 'package:flutter/material.dart';
import 'package:hr_application/utils/theme/app_colors.dart';

final borderRadius = BorderRadius.circular(12);

List<BoxShadow> get kBoxShadow => [
      BoxShadow(
        color: AppColors.kGrey300.withOpacity(.2),
        offset: const Offset(0, 4),
        blurRadius: 6,
        spreadRadius: 2,
      ),
    ];

BoxDecoration get kBoxDecoration => BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: AppColors.kWhite,
      boxShadow: kBoxShadow,
    );

Size get buttonFixedSize => const Size(double.maxFinite, 50);
TextStyle get btnTextStyle => const TextStyle(
      fontSize: 15,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    );
final appTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: AppColors.kWhite,
      fixedSize: buttonFixedSize,
      textStyle: btnTextStyle,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kWhite,
      foregroundColor: AppColors.kGrey300,
      fixedSize: buttonFixedSize,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: AppColors.kGrey300,
          width: .7,
        ),
      ),
      side: BorderSide(
        color: AppColors.kGrey300,
        width: .7,
      ),
      shadowColor: AppColors.kGrey300,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.5),
    ),
  ),
  chipTheme: ChipThemeData(
    checkmarkColor: AppColors.kWhite,
    selectedColor: AppColors.kPrimaryColor,
    backgroundColor: AppColors.kPrimaryColor.withOpacity(.09),
    side: const BorderSide(
      color: AppColors.kGrey300,
      width: .7,
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.kBlack900,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      height: 16 / 11,
      fontWeight: FontWeight.w300,
      color: AppColors.kBlack900,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w300,
      color: AppColors.kBlack900,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w300,
      color: AppColors.kBlack900,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
    titleMedium: TextStyle(
      fontSize: 15,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      height: 28 / 22,
      fontWeight: FontWeight.w500,
      color: AppColors.kBlack900,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      height: 32 / 24,
      fontWeight: FontWeight.w500,
      color: AppColors.kBlack900,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      height: 36 / 28,
      fontWeight: FontWeight.w500,
      color: AppColors.kBlack900,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w500,
      color: AppColors.kBlack900,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      height: 44 / 36,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      height: 52 / 45,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
    displayLarge: TextStyle(
      fontSize: 56,
      height: 64 / 56,
      fontWeight: FontWeight.w400,
      color: AppColors.kBlack900,
    ),
  ),
  scaffoldBackgroundColor: AppColors.kWhite,
);
