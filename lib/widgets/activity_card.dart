import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';

class ActivityCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final DateTime dateTime;
  final String description;
  const ActivityCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.dateTime,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: kBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.kFoundationPurple100,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  iconData,
                  size: 24,
                ),
              ),
            ),
            10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.titleLarge,
                ),
                Text(
                  dateTime.toMMDDYY,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.kGrey300,
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateTime.tohhMMh,
                  style: Get.textTheme.titleLarge,
                ),
                Text(
                  description,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.kGrey300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
