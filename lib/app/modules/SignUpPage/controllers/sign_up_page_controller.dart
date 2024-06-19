import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/SignUpPage/model/working_days_model.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_images.dart';
import 'package:hr_application/utils/helper_function.dart';

class SignUpPageController extends GetxController {
  String get appImageLogo => AppImages.appLogo;
  var usernameTC = TextEditingController(
        text: kDebugMode ? "nitish_gupta@tijoree.money" : null,
      ),
      passTC = TextEditingController(
        text: kDebugMode ? "nitish_gupta@tijoree.money" : null,
      ),
      fullNameTC = TextEditingController(
        text: kDebugMode ? "Nitish Gupta" : null,
      ),
      paidLeaveTC = TextEditingController(
        text: kDebugMode ? "2" : null,
      ),
      casualSickTC = TextEditingController(
        text: kDebugMode ? "2" : null,
      ),
      wfhTC = TextEditingController(
        text: kDebugMode ? "2" : null,
      ),
      organizationTC = TextEditingController(
        text: kDebugMode ? "Tijoree" : null,
      );
  var workingDays = <WorkingDaysModel>[].obs;
  var startTime = Rxn<TimeOfDay?>(null), endTime = Rxn<TimeOfDay?>(null);
  // var isEmployeeSignup = true.obs;

  var formKey = GlobalKey<FormState>();
  var isSaveLoading = false.obs;

  @override
  void onInit() {
    workingDays.value = <String>[
      "Monday", // MONDAY
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ]
        .map(
          (e) => WorkingDaysModel(
            label: e,
            code: e.toUpperCase(),
            isSelected: kDebugMode,
          ),
        )
        .toList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  onWorkingDaysChange(int index) {
    workingDays[index].isSelected = !workingDays[index].isSelected;
    workingDays.refresh();
  }

  void gotToLoginPage() {
    Get.offAllNamed(Routes.LOGIN_PAGE);
  }

  Future<void> signUP() async {
    if (formKey.currentState?.validate() ?? false || !isSaveLoading.value) {
      if (startTime.value == null || endTime.value == null || workingDays.value.where((element) => element.isSelected).isEmpty) {
        showErrorSnack("Select Start and End Time and working days");
        return;
      }
      isSaveLoading.value = true;
      var payload = {};
      List<WorkingDaysModel> tempWorkingdays = List.from(workingDays.value);
      tempWorkingdays.removeWhere((element) => !element.isSelected);
      payload = {
        "username": usernameTC.text.trim(),
        "password": passTC.text,
        "fullName": fullNameTC.text,
        "roleType": UserRoleType.superAdmin.code,
        "companyName": organizationTC.text,
        "inTime": formatTimeOfDay(startTime.value!),
        "outTime": formatTimeOfDay(endTime.value!),
        "wrokingDays": tempWorkingdays.map((e) => e.code).toList(),
        "perMonthPL": num.tryParse(paidLeaveTC.text.trim()),
        "perMonthSLCL": num.tryParse(casualSickTC.text.trim()),
        "perMonthWFH": num.tryParse(paidLeaveTC.text.trim()),
      };
      ApiController.to
          .callPOSTAPI(
        url: APIUrlsService.to.signup,
        body: payload,
      )
          .then((resp) async {
        isSaveLoading.value = false;
        if (resp is Map<String, dynamic> && resp['status']) {
          await AppStorageController.to.login(resp['data'] as Map<String, dynamic>);
          showSuccessSnack("User Logged.");
        } else {
          showErrorSnack((resp['errorMsg'] ?? (resp)).toString());
        }
        print(resp);
      }).catchError((e) {
        print(e);
        isSaveLoading.value = false;
        showErrorSnack((e['errorMsg'] ?? (e)).toString());
      });
    }
  }

  @override
  void onClose() {
    // usernameTC.dispose();
    // passTC.dispose();
    // fullNameTC.dispose();
    // companyIDTC.dispose();
    // organizationTC.dispose();
    super.onClose();
  }
}
