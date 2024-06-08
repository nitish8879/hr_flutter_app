import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/SignUpPage/model/working_days_model.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';

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

  @override
  void onClose() {
    super.onClose();
  }
}
