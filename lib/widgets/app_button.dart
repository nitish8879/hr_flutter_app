import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/utils/theme/app_colors.dart';

class AppButton {
  static Widget appButton({
    required void Function()? onPressed,
    required String label,
    Widget? child,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child ?? Text(label),
    );
  }

  static Widget appImageOulineButton({
    required void Function()? onPressed,
    required String imagePath,
    String label = "Continue with Google",
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 24,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: Get.textTheme.titleMedium,
          )
        ],
      ),
    );
  }

  static Widget appOulineButtonRow({
    required void Function()? onPressed,
    required String label,
    EdgeInsetsGeometry? padding,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (prefixIcon != null) ...{prefixIcon},
            Text(
              label,
              style: Get.textTheme.titleMedium,
            ),
            if (suffixIcon != null) ...{suffixIcon},
          ],
        ),
      ),
    );
  }

  static Widget appOulineButton({
    required void Function()? onPressed,
    required String label,
    EdgeInsetsGeometry? padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: Get.textTheme.labelLarge?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
