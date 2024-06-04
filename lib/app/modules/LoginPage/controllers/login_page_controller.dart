import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/app_images.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:hr_application/widgets/app_textfield.dart';

class LoginPageController extends GetxController {
  String get appImageLogo => AppImages.appLogo;
  var usernameTC = TextEditingController(
        text: kDebugMode ? "nitish_gupta@tijoree.money" : null,
      ),
      passTC = TextEditingController(
        text: kDebugMode ? "nitish_gupta@tijoree.money" : null,
      );
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void gotoSignUpPage() {
    Get.offAllNamed(Routes.SIGN_UP_PAGE);
  }

  void login() {
    if (!isLoading.value) {
      isLoading.value = true;
      ApiController.to.callPOSTAPI(
        url: APIUrlsService.to.login,
        body: {
          "username": usernameTC.text,
          "password": passTC.text,
        },
      ).then((resp) async {
        print(resp.toString());
        isLoading.value = false;
        if (resp is Map<String, dynamic> && resp['status']) {
          if (resp['message'].toString() == "Please set new password.") {
            showResetPasswordDialog();
          } else {
            await AppStorageController.to
                .login(resp['data'] as Map<String, dynamic>);
            showSuccessSnack("User Logged.");
          }
        } else {
          isLoading.value = false;
          showErrorSnack((resp['errorMsg'] ?? (resp)).toString());
        }
        print(resp);
      }).catchError((e) {
        print(e);
        isLoading.value = false;
        if (e is Map<String, dynamic> &&
            e['message'].toString() == "Please set new password.") {
          showResetPasswordDialog();
        } else {
          showErrorSnack((e['errorMsg'] ?? (e)).toString());
        }
      });
    }
  }

  void showResetPasswordDialog() {
    isLoading.value = false;
    String password = "", renterPassword = "";
    Get.defaultDialog(
      title: "Set New Password",
      barrierDismissible: false,
      content: Column(
        children: [
          24.height,
          AppTextField(
            hintText: "Enter new password",
            onChanged: (p) => password = p,
          ),
          24.height,
          AppTextField(
            hintText: "Re-Enter new password",
            onChanged: (p) => renterPassword = p,
          ),
          24.height,
        ],
      ),
      textCancel: "Cancel",
      onCancel: closeDialogs,
      textConfirm: "Update Password",
      onConfirm: () async {
        if (renterPassword.trim().isEmpty || password != renterPassword) {
          showErrorSnack("Please enter corrent passowrd");
          return;
        }
        final resp = await ApiController.to.callGETAPI(
          url: APIUrlsService.to
              .updatePassword(usernameTC.text, passTC.text, renterPassword),
        );
        if (resp is Map<String, dynamic> && resp['status']) {
          passTC.text = renterPassword;
          closeDialogs();
          login();
        }
      },
    );
  }

  @override
  void onClose() {
    usernameTC.dispose();
    passTC.dispose();
    super.onClose();
  }
}
