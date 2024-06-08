import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:hr_application/widgets/app_button.dart';
import 'package:hr_application/widgets/app_textfield.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          24.height,
          title("User Details", Icons.person),
          24.height,
          AppTextField(
            hintText: "Username",
            controller: controller.userName,
            readOnly: true,
          ),
          16.height,
          FilledButton(
            onPressed: showResetPasswordDialog,
            child: Text("Update Password"),
          ),
          16.height,
          FilledButton(
            onPressed: AppStorageController.to.logout,
            child: Text("Log out"),
          ),
          if (AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin) ...[
            36.height,
            organizationDetails(context),
          ],
        ],
      ),
    );
  }

  void showResetPasswordDialog() {
    String oldPassWord = "", newPassword = "";
    Get.defaultDialog(
      title: "Set New Password",
      barrierDismissible: false,
      content: Column(
        children: [
          24.height,
          AppTextField(
            hintText: "Enter Old password",
            onChanged: (p) => oldPassWord = p,
          ),
          24.height,
          AppTextField(
            hintText: "enter new password",
            onChanged: (p) => newPassword = p,
          ),
          24.height,
        ],
      ),
      textCancel: "Cancel",
      onCancel: closeDialogs,
      textConfirm: "Update Password",
      onConfirm: () async {
        if (oldPassWord.trim().isEmpty || newPassword.trim().isEmpty) {
          showErrorSnack("Please enter old Password and New Password");
          return;
        }
        final resp = await ApiController.to.callGETAPI(
          url: APIUrlsService.to.updatePassword(
            controller.userName.text,
            oldPassWord,
            newPassword,
          ),
        );
        if (resp is Map<String, dynamic>) {
          if (resp['status']) {
            closeDialogs();
            showSuccessSnack("Password updated");
          } else {
            showSuccessSnack(resp['errorMsg'] ?? resp.toString());
          }
        }
      },
    );
  }

  Widget title(String name, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: Get.textTheme.titleLarge,
          ),
          const SizedBox(width: 10),
          Icon(
            iconData,
            size: 20,
            color: AppColors.kBlue600,
          )
        ],
      ),
    );
  }

  Future<void> openTimePickerdialog(bool isStartTime, BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      if (isStartTime) {
        controller.startTime.value = selectedTime;
      } else {
        controller.endTime.value = selectedTime;
      }
    }
  }

  Widget organizationDetails(BuildContext context) {
    return Column(
      children: [
        title("Organization Details", Icons.people_alt_outlined),
        16.height,
        AppTextField(
          hintText: "Organization Name",
          controller: controller.organizationTC,
          validator: (val) {
            if (val?.isEmpty ?? true) {
              return "This field can't be empty";
            } else {
              return null;
            }
          },
        ),
        16.height,
        Obx(() {
          return AppButton.appOulineButtonRow(
            onPressed: () => openTimePickerdialog(true, context),
            label: controller.startTime.value == null ? "Select start time" : formatTimeOfDay(controller.startTime.value!),
            suffixIcon: const Icon(
              Icons.access_time_outlined,
              color: AppColors.kBlue600,
            ),
          );
        }),
        16.height,
        Obx(() {
          return AppButton.appOulineButtonRow(
            onPressed: () => openTimePickerdialog(false, context),
            label: controller.endTime.value == null ? "Select end time" : formatTimeOfDay(controller.endTime.value!),
            suffixIcon: const Icon(
              Icons.access_time_outlined,
              color: AppColors.kBlue600,
            ),
          );
        }),
        16.height,
        DecoratedBox(
          decoration: kBoxDecoration,
          child: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                return Wrap(
                  spacing: 10,
                  runSpacing: 15,
                  children: List.generate(
                    controller.workingDays.value.length,
                    (index) => ChoiceChip(
                      label: Text(
                        controller.workingDays[index].label,
                        style: Get.textTheme.bodySmall?.copyWith(
                          color: controller.workingDays[index].isSelected ? AppColors.kWhite : AppColors.black,
                        ),
                      ),
                      selected: controller.workingDays[index].isSelected,
                      onSelected: (value) => controller.onWorkingDaysChange(index),
                    ),
                  ).toList(),
                );
              }),
            ),
          ),
        ),
        16.height,
        FilledButton(
          onPressed: controller.updateCompany,
          child: Text("Update Organization"),
        ),
        50.height,
      ],
    );
  }
}
