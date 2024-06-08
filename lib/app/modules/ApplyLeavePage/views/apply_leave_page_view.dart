import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/models/team_members_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/widgets/app_button.dart';
import 'package:hr_application/widgets/app_textfield.dart';

import '../controllers/apply_leave_page_controller.dart';

class ApplyLeavePageView extends GetView<ApplyLeavePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: controller.goBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Apply Leave"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          16.height,
          Text("Select Leave Type"),
          StatefulBuilder(builder: (context, s) {
            return DropdownButton<String>(
              items: LeaveType.list
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              value: controller.selectedLeaveType?.readableName,
              isExpanded: true,
              onChanged: (a) {
                controller.selectedLeaveType = LeaveType.fromString(a!);
                if (controller.selectedLeaveType == LeaveType.ONEDAY) {
                  controller.canShowToDate = false;
                } else {
                  controller.canShowToDate = true;
                }
                controller.leaveEndDate.refresh();
                controller.leaveStartDate.refresh();
                s(() {});
              },
            );
          }),
          24.height,
          Obx(() {
            return AppButton.appOulineButtonRow(
              onPressed: () => openDatePickerdialog(true, context),
              label: controller.leaveStartDate.value?.toMMDDYYYY ?? "Select ${controller.selectedLeaveType == LeaveType.ONEDAY ? '' : 'start '}date",
              suffixIcon: const Icon(
                Icons.date_range,
                color: AppColors.kBlue600,
              ),
            );
          }),
          24.height,
          Obx(() {
            controller.leaveEndDate.value;
            if (!controller.canShowToDate) {
              return SizedBox();
            }
            return AppButton.appOulineButtonRow(
              onPressed: () => openDatePickerdialog(false, context),
              label: controller.leaveEndDate.value?.toMMDDYYYY ?? "Select end date",
              suffixIcon: const Icon(
                Icons.date_range,
                color: AppColors.kBlue600,
              ),
            );
          }),
          24.height,
          AppTextField(
            hintText: "Reason for leave",
            controller: controller.leavereasonTC,
          ),
          24.height,
          Text("Select Approval Person"),
          Obx(() {
            if (controller.isTeamLoading.value) {
              return UnconstrainedBox(child: CircularProgressIndicator());
            }
            if (controller.adminMembers.isEmpty) {
              return Text("No Admin Members Found");
            }
            return DropdownButton<MembersData>(
              items: controller.adminMembers
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.fullName ?? ""),
                    ),
                  )
                  .toList(),
              value: controller.selectedTeam,
              onChanged: (a) {
                controller.selectedTeam = a;
              },
              isExpanded: true,
            );
          }),
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
    final companyworkingdays = workingDays(AppStorageController.to.currentUser?.wrokingDays ?? []);
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      initialDate: isStartDate ? controller.leaveStartDate.value : controller.leaveEndDate.value,
      selectableDayPredicate: (day) {
        return companyworkingdays.contains(day.weekday);
      },
    );
    if (selectedDate != null) {
      if (isStartDate) {
        if (controller.selectedLeaveType == LeaveType.ONEDAY) {
          controller.leaveEndDate.value = selectedDate;
        } else {
          controller.leaveEndDate.value = null;
        }
        controller.leaveStartDate.value = selectedDate;
      } else {
        controller.leaveEndDate.value = selectedDate;
      }
    }
  }
}
