import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_images.dart';
import 'package:hr_application/utils/helper_function.dart';

class LoginPageController extends GetxController {
  String get appImageLogo => AppImages.appLogo;
  var usernameTC = TextEditingController(
        text: kDebugMode ? "nitishCUser" : null,
      ),
      passTC = TextEditingController(
        text: kDebugMode ? "nitish12" : null,
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
    Get.toNamed(Routes.SIGN_UP_PAGE);
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
          await AppStorageController.to
              .login(resp['data'] as Map<String, dynamic>);
          showSuccessSnack("User Logged.");
        } else {
          showErrorSnack((resp['errorMsg'] ?? (resp)).toString());
        }
        print(resp);
      }).catchError((e) {
        print(e);
        isLoading.value = false;
        showErrorSnack((e['errorMsg'] ?? (e)).toString());
      });
    }
  }

  @override
  void onClose() {
    usernameTC.dispose();
    passTC.dispose();
    super.onClose();
  }
}
