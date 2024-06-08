import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:hr_application/widgets/app_button.dart';
import 'package:hr_application/widgets/app_textfield.dart';
import 'package:intl/intl.dart';

import '../controllers/holiday_page_controller.dart';

class HolidayPageView extends GetView<HolidayPageController> {
  const HolidayPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        title: const Text('Holidays'),
      ),
      floatingActionButton: _buildAddHolidayWidget(context),
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

  Widget _buildAddHolidayWidget(BuildContext context) {
    DateTime? selectedDate;
    String? label;
    return AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin
        ? FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Add Holiday",
                onCancel: closeDialogs,
                contentPadding: EdgeInsets.all(24),
                content: Column(
                  children: [
                    AppTextField(
                      hintText: "Label",
                      onChanged: (val) => label = val,
                    ),
                    24.height,
                    StatefulBuilder(builder: (context, re) {
                      return AppButton.appOulineButtonRow(
                        onPressed: () async {
                          final a = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                            initialDate: selectedDate,
                          );
                          if (a != null) {
                            selectedDate = a;
                            re(() {});
                          }
                        },
                        label: selectedDate == null ? "Select Date" : selectedDate!.toDDMMYYYY,
                        suffixIcon: const Icon(
                          Icons.access_time_outlined,
                          color: AppColors.kBlue600,
                        ),
                      );
                    }),
                  ],
                ),
                onConfirm: () => controller.addHoliday(selectedDate, label),
                textConfirm: "Add",
              );
            },
            child: const Icon(Icons.add),
          )
        : SizedBox();
  }

  Widget _buildItem(int index) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: kBoxDecoration,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
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
                      ],
                    ),
                    if (controller.allHolidays[index].holidayDate != null) ...{
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
                  style: Get.textTheme.headlineSmall?.copyWith(),
                ),
              ],
            ),
          ),
          if (AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin) ...[
            IconButton(
              onPressed: () => controller.deleteHoliday(controller.allHolidays[index]),
              icon: const Icon(Icons.delete),
            )
          ],
        ],
      ),
    );
  }
}
