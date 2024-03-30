import 'package:get/get.dart';
import 'package:hr_application/app/modules/AllEmployesPage/model/all_employee_model.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/helper_function.dart';

class AllEmployesPageController extends GetxController {
  var allEmployees = <AllEmployeeModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getAllEmployee();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getAllEmployee() {
    ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.allEmployeeByCompany(
        AppStorageController.to.currentUser!.companyID!,
      ),
    )
        .then((resp) {
      if (resp != null && resp is Map<String, dynamic> && resp['status']) {
        allEmployees.clear();
        allEmployees.addAll(
          (resp['data'] as List<dynamic>).map((e) => AllEmployeeModel.fromJson(e)).toList(),
        );
      } else {
        showErrorSnack((resp['errorMsg'] ?? resp).toString());
      }
    });
  }
}
