import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/app_string.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/widgets/app_button.dart';
import 'package:hr_application/widgets/app_textfield.dart';

import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            24.height,
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                controller.appImageLogo,
                height: 100,
              ),
            ),
            24.height,
            Text(
              "Welcome back  $hiEmoji",
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
              "Hello there, login to continue",
              style: Get.textTheme.bodyMedium?.copyWith(
                color: AppColors.kGrey300,
              ),
            ),
            16.height,
            AppTextField(
              hintText: "Username",
              controller: controller.usernameTC,
            ),
            16.height,
            AppTextField(
              hintText: "Password",
              isPassword: true,
              controller: controller.passTC,
            ),
            34.height,
            Obx(() {
              return AppButton.appButton(
                onPressed: controller.login,
                label: "Log in",
                child: controller.isLoading.value
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
                      text: "Don't have an account? ",
                      style: Get.textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: " Create Organization",
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: AppColors.kBlue900,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = controller.gotoSignUpPage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
