import 'package:get/get.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_images.dart';

class SplashScreenPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    checkUserIsLogged();
  }

  String get appImageLogo => AppImages.appLogo;

  Future<void> checkUserIsLogged() async {
    await Future.delayed(const Duration(seconds: 1));
    if (await AppStorageController.to.isUserLoggedIn()) {
      Get.offAndToNamed(Routes.DASHBOARD_PAGE);
    } else {
      Get.offAndToNamed(Routes.LOGIN_PAGE);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
