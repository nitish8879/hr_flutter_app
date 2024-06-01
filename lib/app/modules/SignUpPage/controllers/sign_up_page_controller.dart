import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/SignUpPage/model/working_days_model.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_images.dart';
import 'package:hr_application/utils/helper_function.dart';

class SignUpPageController extends GetxController {
  String get appImageLogo => AppImages.appLogo;
  var usernameTC = TextEditingController(
        text: kDebugMode ? "nitish12" : null,
      ),
      passTC = TextEditingController(
        text: kDebugMode ? "nitish12" : null,
      ),
      fullNameTC = TextEditingController(
        text: kDebugMode ? "nitish12" : null,
      ),
      organizationTC = TextEditingController(
        text: kDebugMode ? "nitish12" : null,
      ),
      companyIDTC = TextEditingController();
  var workingDays = <WorkingDaysModel>[].obs;
  var startTime = "05:45:46".obs, endTime = "07:45:46".obs;
  var isEmployeeSignup = true.obs;

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
            isSelected: false,
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

  Future<void> signUP() async {
    if (formKey.currentState?.validate() ?? false || !isSaveLoading.value) {
      isSaveLoading.value = true;
      var payload = {};
      List<WorkingDaysModel> tempWorkingdays = List.from(workingDays.value);
      tempWorkingdays.removeWhere((element) => !element.isSelected);
      if (isEmployeeSignup.value) {
        payload = {
          "username": usernameTC.text.trim(),
          "password": passTC.text,
          "fullName": fullNameTC.text,
          "roleType": "EMPLOYEE",
          "companyID": num.tryParse(companyIDTC.text),
        };
      } else {
        payload = {
          "username": usernameTC.text.trim(),
          "password": passTC.text,
          "fullName": fullNameTC.text,
          "roleType": "SUPERADMIN",
          "companyName": organizationTC.text,
          "inTime": startTime.value,
          "outTime": endTime.value,
          "wrokingDays": tempWorkingdays.map((e) => e.code).toList(),
        };
      }
      await Future.delayed(Duration(seconds: 2));
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
    usernameTC.dispose();
    passTC.dispose();
    fullNameTC.dispose();
    companyIDTC.dispose();
    organizationTC.dispose();
    super.onClose();
  }
}
