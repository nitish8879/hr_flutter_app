import 'package:get/get.dart';

import '../controllers/all_employes_page_controller.dart';

class AllEmployesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllEmployesPageController>(
      () => AllEmployesPageController(),
    );
  }
}
