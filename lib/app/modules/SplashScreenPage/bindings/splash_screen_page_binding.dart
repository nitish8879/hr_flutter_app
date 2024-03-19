import 'package:get/get.dart';

import '../controllers/splash_screen_page_controller.dart';

class SplashScreenPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenPageController>(
      () => SplashScreenPageController(),
    );
  }
}
