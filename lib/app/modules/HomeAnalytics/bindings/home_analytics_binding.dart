import 'package:get/get.dart';

import '../controllers/home_analytics_controller.dart';

class HomeAnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeAnalyticsController>(
      () => HomeAnalyticsController(),
    );
  }
}
