import 'package:get/get.dart';

import '../controllers/holiday_page_controller.dart';

class HolidayPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HolidayPageController>(
      () => HolidayPageController(),
    );
  }
}
