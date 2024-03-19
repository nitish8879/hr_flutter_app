import 'package:get/get.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(
      () => ProfilePageController(),
    );
  }
}
