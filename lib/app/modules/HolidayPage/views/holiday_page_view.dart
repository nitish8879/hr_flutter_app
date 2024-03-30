import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:intl/intl.dart';

import '../controllers/holiday_page_controller.dart';

class HolidayPageView extends GetView<HolidayPageController> {
  const HolidayPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holiday List'),
      ),
      body: Obx(() {
        if (controller.isLloading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.allHolidays.isEmpty) {
          return const Center(
            child: Text(
              'No Holliday found.',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: controller.allHolidays.length,
            padding: const EdgeInsets.only(bottom: 80),
            itemBuilder: (context, index) {
              return _buildItem(index);
            },
          );
        }
      }),
    );
  }

  Widget _buildItem(int index) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: kBoxDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.kBlack900,
                size: 28,
              ),
              16.width,
              if (controller.allHolidays[index].holidayDate != null) ...{
                Text(
                  DateFormat("yyyy-MM-ddTHH:mm:ss").parse(controller.allHolidays[index].holidayDate!).toMMDDYYYY,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    fontSize: 18,
                  ),
                ),
              },
              if (controller.allHolidays[index].holidayDate != null) ...{
                const Spacer(),
                Text(
                  DateFormat("yyyy-MM-ddTHH:mm:ss").parse(controller.allHolidays[index].holidayDate!).toWEEKDAY,
                  style: Get.textTheme.labelLarge,
                ),
              },
            ],
          ),
          16.height,
          Text(
            controller.allHolidays[index].label ?? "-",
            style: Get.textTheme.headlineSmall?.copyWith(
                // fontSize: 18,
                ),
          ),
        ],
      ),
    );
  }
}
