import 'package:get/get.dart';

import '../controllers/sign_up_page_controller.dart';

class SignUpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpPageController>(
      () => SignUpPageController(),
    );
  }
}
