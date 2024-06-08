import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/SignUpPage/model/working_days_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/helper_function.dart';

class ProfilePageController extends GetxController {
  var userName = TextEditingController(text: AppStorageController.to.currentUser?.username);
  var password = TextEditingController();
  var organizationTC = TextEditingController(
    text: AppStorageController.to.currentUser?.companyName,
  );

  var workingDays = <WorkingDaysModel>[].obs;
  var startTime = Rxn<TimeOfDay?>(null), endTime = Rxn<TimeOfDay?>(null);

  @override
  void onInit() {
    workingDays.value = <String>[
      "Monday",
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
            isSelected: AppStorageController.to.currentUser?.wrokingDays?.contains(e.toUpperCase()) ?? false,
          ),
        )
        .toList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    var startTimeTemp = AppStorageController.to.currentUser?.inTime ?? "00:00:00";
    var endTimeTemp = AppStorageController.to.currentUser?.outTime ?? "00:00:00";
    startTime.value = TimeOfDay(hour: int.tryParse(startTimeTemp.split(":")[0]) ?? 0, minute: int.tryParse(startTimeTemp.split(":")[1]) ?? 0);
    endTime.value = TimeOfDay(hour: int.tryParse(endTimeTemp.split(":")[0]) ?? 0, minute: int.tryParse(endTimeTemp.split(":")[1]) ?? 0);
  }

  onWorkingDaysChange(int index) {
    workingDays[index].isSelected = !workingDays[index].isSelected;
    workingDays.refresh();
  }

  Future<void> updateCompany() async {
    if (AppStorageController.to.currentUser?.roleType != UserRoleType.superAdmin) {
      showErrorSnack("Super admin can edit this only");
    } else {
      List<WorkingDaysModel> tempWorkingdays = List.from(workingDays.value);
      tempWorkingdays.removeWhere((element) => !element.isSelected);
      final resp = await ApiController.to.callPOSTAPI(
        url: APIUrlsService.to.updateCompany,
        body: {
          "userId": AppStorageController.to.currentUser?.userID,
          "companyID": AppStorageController.to.currentUser?.companyID,
          "companyName": organizationTC.text,
          "inTime": formatTimeOfDay(startTime.value!),
          "outTime": formatTimeOfDay(endTime.value!),
          "workingDays": tempWorkingdays.map((e) => e.code).toList(),
        },
      ).catchError((e) {
        Get.defaultDialog(
          title: "Error",
          content: Text(
            e.toString(),
            maxLines: 4,
          ),
        );
      });
      if (resp is Map<String, dynamic>) {
        if (resp['status']) {
          showSuccessSnack("Company Data Updated");
          AppStorageController.to.currentUser?.wrokingDays = (resp['data']['workingDays'] as List<dynamic>).cast<String>();
          AppStorageController.to.currentUser?.outTime = resp['data']['outTime'];
          AppStorageController.to.currentUser?.inTime = resp['data']['inTime'];
          AppStorageController.to.currentUser?.companyName = resp['data']['companyName'];
          await AppStorageController.to.saveUserData(AppStorageController.to.currentUser!.toJson());
        } else {
          Get.defaultDialog(
            title: "Error",
            content: Text(
              (resp['errorMsg'] ?? resp).toString(),
              maxLines: 4,
            ),
          );
        }
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
