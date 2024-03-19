import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';

class HorizontalDate extends StatelessWidget {
  final DateTime fromDate, toDate, selectedDate;
  final void Function(DateTime newDate)? onTap;
  const HorizontalDate({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.selectedDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        fromDate.difference(toDate).inDays,
        (index) {
          DateTime currentDate = fromDate.subtract(Duration(days: index));
          bool isSelected = currentDate.year == selectedDate.year && currentDate.month == selectedDate.month && currentDate.day == selectedDate.day;
          return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 16 : 8, right: 8),
              child: InkWell(
                borderRadius: borderRadius,
                onTap: isSelected ? null : () => onTap!(currentDate),
                child: Ink(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.kFoundationPurple700 : AppColors.kWhite,
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: AppColors.kBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentDate.day.toString(),
                        style: Get.textTheme.headlineMedium?.copyWith(
                          color: isSelected ? AppColors.kWhite : AppColors.kBlack900,
                        ),
                      ),
                      Text(
                        currentDate.toMMOnly,
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? AppColors.kWhite : AppColors.kBlack900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
