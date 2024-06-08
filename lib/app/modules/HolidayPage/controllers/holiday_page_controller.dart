import 'package:get/get.dart';
import 'package:hr_application/app/modules/HolidayPage/model/holiday_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/helper_function.dart';

class HolidayPageController extends GetxController {
  var allHolidays = <HolidayModel>[].obs;
  var isLloading = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getAllHoliday();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getAllHoliday() {
    ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.allHolidayByCompanyID(
        AppStorageController.to.currentUser!.companyID!,
      ),
    )
        .then((resp) {
      if (resp != null && resp is List<dynamic>) {
        allHolidays.clear();
        allHolidays.addAll(
          resp.map((e) => HolidayModel.fromJson(e)).toList(),
        );
      } else {
        showErrorSnack((resp['errorMsg'] ?? resp).toString());
      }
      isLloading.value = false;
    }).catchError((e) {
      isLloading.value = false;
      showErrorSnack((e).toString());
    });
  }

  Future<void> addHoliday(DateTime? selectedDate, String? label) async {
    if (AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin) {
      
    } else {
      showErrorSnack("Super Admin can only add this");
    }
  }
}
