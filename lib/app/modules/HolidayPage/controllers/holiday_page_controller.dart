import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/HolidayPage/model/holiday_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
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
    if (!isLloading.value) {
      isLloading.value = true;
    }
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
      final resp = await ApiController.to.callPOSTAPI(
        url: APIUrlsService.to.createHoliday,
        body: {
          "userID": AppStorageController.to.currentUser?.userID,
          "companyID": AppStorageController.to.currentUser?.companyID,
          "label": label,
          "date": selectedDate!.toYYYMMDD, //yyyy-MM-dd
        },
      );
      if (resp is Map<String, dynamic>) {
        if (resp['status']) {
          closeDialogs();
          getAllHoliday();
        } else {
          showErrorSnack(resp.toString());
        }
      } else {
        showErrorSnack(resp.toString());
      }
    } else {
      showErrorSnack("Super Admin can only add this");
    }
  }

  deleteHoliday(HolidayModel holiday) {
    if (AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin) {
      Get.defaultDialog(
        title: "Delete",
        content: const Text("Are you sure you want to delete this?"),
        textCancel: "No",
        onCancel: closeDialogs,
        textConfirm: "Yes",
        onConfirm: () async {
          final resp = await ApiController.to.callPOSTAPI(
            url: APIUrlsService.to.deleteHoliday,
            body: {
              "userID": AppStorageController.to.currentUser?.userID,
              "companyID": AppStorageController.to.currentUser?.companyID,
              "holidayID": holiday.id,
            },
          );
          if (resp is Map<String, dynamic>) {
            if (resp['status']) {
              closeDialogs();
              getAllHoliday();
            } else {
              showErrorSnack(resp.toString());
            }
          } else {
            showErrorSnack(resp.toString());
          }
        },
      );
    } else {
      showErrorSnack("Super Admin can only delete this");
    }
  }
}
