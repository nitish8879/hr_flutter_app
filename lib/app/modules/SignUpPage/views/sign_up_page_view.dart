import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:hr_application/widgets/app_button.dart';
import 'package:hr_application/widgets/app_textfield.dart';

import '../controllers/sign_up_page_controller.dart';

class SignUpPageView extends GetView<SignUpPageController> {
  const SignUpPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              24.height,
              Text(
                "Register Account",
                style: Get.textTheme.headlineLarge,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "to",
                      style: Get.textTheme.headlineLarge,
                    ),
                    TextSpan(
                      text: " HR Attendence",
                      style: Get.textTheme.headlineLarge?.copyWith(
                        color: AppColors.kBlue900,
                      ),
                    ),
                  ],
                ),
              ),
              16.height,
              Text(
                "Hello there, singup to continue",
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: AppColors.kGrey300,
                ),
              ),
              16.height,
              AppTextField(
                hintText: "Full Name",
                controller: controller.fullNameTC,
                validator: (val) {
                  if (val?.isEmpty ?? true) {
                    return "This field can't be empty";
                  } else {
                    return null;
                  }
                },
              ),
              16.height,
              AppTextField(
                hintText: "Username ",
                controller: controller.usernameTC,
              ),
              16.height,
              AppTextField(
                hintText: "Password",
                isPassword: true,
                controller: controller.passTC,
              ),
              16.height,
              Obx(() {
                return SwitchListTile(
                  dense: true,
                  value: controller.isEmployeeSignup.value,
                  onChanged: (value) => controller.isEmployeeSignup.value = value,
                  title: Text(
                    controller.isEmployeeSignup.value ? "Employe Signup" : "Admin Signup",
                    style: Get.textTheme.bodyLarge,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
              Obx(() {
                return Visibility(
                  visible: !controller.isEmployeeSignup.value,
                  replacement: Column(
                    children: [
                      title("Employee Details", Icons.person),
                      AppTextField(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        hintText: "Company ID",
                        controller: controller.companyIDTC,
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return "This field can't be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      title("Organization Details", Icons.people_alt_outlined),
                      16.height,
                      AppTextField(
                        hintText: "Organization Name",
                        controller: controller.organizationTC,
                      ),
                      16.height,
                      Obx(() {
                        return AppButton.appOulineButtonRow(
                          onPressed: () => openTimePickerdialog(true, context),
                          label: controller.startTime.isEmpty ? "Select start time" : controller.startTime.value,
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
                          label: controller.endTime.isEmpty ? "Select end time" : controller.endTime.value,
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
                      )
                    ],
                  ),
                );
              }),
              45.height,
              Obx(() {
                return AppButton.appButton(
                  onPressed: controller.signUP,
                  label: "Signup",
                  child: controller.isSaveLoading.value
                      ? const Center(
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              color: AppColors.kWhite,
                              strokeWidth: 1.5,
                            ),
                          ),
                        )
                      : null,
                );
              }),
              20.height,
              Align(
                alignment: Alignment.topCenter,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: Get.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: " Login",
                        style: Get.textTheme.bodySmall?.copyWith(
                          color: AppColors.kBlue900,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = Get.back,
                      ),
                    ],
                  ),
                ),
              ),
              20.height,
            ],
          ),
        ),
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
        controller.startTime.value = "${selectedTime.hour}:${selectedTime.minute}:00";
      } else {
        controller.endTime.value = "${selectedTime.hour}:${selectedTime.minute}:00";
      }
    }
  }

  Widget title(String name, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
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
}
