import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/LeavePage/controllers/leave_page_controller.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/widgets/app_button.dart';
import 'package:hr_application/widgets/app_textfield.dart';

class ApplyLeavePageView extends GetView<LeavePageController> {
  const ApplyLeavePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply Leave"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Obx(() {
            return AppButton.appOulineButtonRow(
              onPressed: () => openDatePickerdialog(true, context),
              label: controller.leaveStartDate.value?.toMMDDYYYY ?? "Select start date",
              suffixIcon: const Icon(
                Icons.date_range,
                color: AppColors.kBlue600,
              ),
            );
          }),
          16.height,
          Obx(() {
            return AppButton.appOulineButtonRow(
              onPressed: () => openDatePickerdialog(false, context),
              label: controller.leaveEndDate.value?.toMMDDYYYY ?? "Select end date",
              suffixIcon: const Icon(
                Icons.date_range,
                color: AppColors.kBlue600,
              ),
            );
          }),
          16.height,
          AppTextField(
            hintText: "Reason for leave",
            controller: controller.leavereasonTC,
          ),
          16.height,
          AppButton.appButton(
            onPressed: controller.appllyLeave,
            label: "Submit",
          )
        ],
      ),
    );
  }

  Future<void> openDatePickerdialog(bool isStartDate, BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      initialDate: isStartDate ? controller.leaveStartDate.value : controller.leaveEndDate.value,
    );
    if (selectedDate != null) {
      if (isStartDate) {
        controller.leaveStartDate.value = selectedDate;
      } else {
        controller.leaveEndDate.value = selectedDate;
      }
    }
  }
}
