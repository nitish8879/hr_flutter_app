import 'package:get/get.dart';

import '../controllers/leave_page_controller.dart';

class LeavePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeavePageController>(
      () => LeavePageController(),
    );
  }
}
