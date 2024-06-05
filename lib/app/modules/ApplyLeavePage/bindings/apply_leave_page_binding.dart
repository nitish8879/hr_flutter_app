import 'package:get/get.dart';

import '../controllers/apply_leave_page_controller.dart';

class ApplyLeavePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyLeavePageController>(
      () => ApplyLeavePageController(),
    );
  }
}
