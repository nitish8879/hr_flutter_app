import 'package:get/get.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';

class HomeAnalyticsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchHomeAnalyticsData();
  }

  Future<void> fetchHomeAnalyticsData() async {
    final resp = await ApiController.to.callGETAPI(
      url: APIUrlsService.to.homeAnalyticsData(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
      ),
    );

    print(resp);
  }

  @override
  void onClose() {}
}
