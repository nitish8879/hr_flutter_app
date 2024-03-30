import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_activity_model.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_total_count.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';

class LeavePageController extends GetxController {
  var tabSelected = Rxn(LeaveActivityState.approved);
  var leaveActivities = <LeaveActivityModel>[].obs;
  var leavTotalCount = Rxn<LeaveTotalCountModel?>(null);
  var mainList = <LeaveActivityModel>[];
  var leavereasonTC = TextEditingController();
  var leaveStartDate = Rxn<DateTime?>(), leaveEndDate = Rxn<DateTime?>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getTotalLeave();
    getAllLeaves();
  }

  Future<void> onRefresh() async {
    getTotalLeave();
    getAllLeaves();
  }

  void onTabChange(LeaveActivityState newState) {
    // if (newState == tabSelected.value) return;
    tabSelected.value = newState;
    leaveActivities.clear();
    leaveActivities.addAll(mainList.where((element) => element.leaveStatus == newState));
    print(leaveActivities.length);
  }

  void appllyLeave() {
    ApiController.to.callPOSTAPI(
      url: APIUrlsService.to.addLeave,
      body: {
        "userID": AppStorageController.to.currentUser?.userID,
        "companyID": AppStorageController.to.currentUser?.companyID,
        "approvalTo": AppStorageController.to.currentUser?.adminID,
        "leaveStatus": "PENDING",
        "fromdate": leaveStartDate.value?.toDDMMYYYY,
        "todate": leaveEndDate.value?.toDDMMYYYY,
        "leaveReason": leavereasonTC.text,
      },
    ).then((resp) {
      if (resp != null && resp is Map<String, dynamic> && resp['status']) {
        leavereasonTC.clear();
        leaveStartDate.value = null;
        leaveEndDate.value = null;
        Get.back();

        onRefresh();
      } else {
        showErrorSnack((resp['errorMsg'] ?? resp).toString());
      }
    });
  }

  void getTotalLeave() {
    ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.getTotalCountLeave(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
      ),
    )
        .then((resp) {
      if (resp != null && resp['status']) {
        leavTotalCount.value = LeaveTotalCountModel.fromJson(resp['data']);
        print(leavTotalCount.value?.toJson() ?? "Got null in Total leave count");
      } else {
        showErrorSnack(resp.toString());
      }
    }).catchError(
      (e) {
        showErrorSnack(e.toString());
      },
    );
  }

  void getAllLeaves() {
    ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.getTotalLeaves(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
      ),
    )
        .then((resp) {
      if (resp != null && resp['status']) {
        leaveActivities.clear();
        mainList.clear();
        mainList.addAll((resp['data'] as List<dynamic>).map((e) => LeaveActivityModel.fromJson(e)).toList());
        onTabChange(LeaveActivityState.approved);
      } else {
        showErrorSnack(resp.toString());
      }
    }).catchError(
      (e) {
        showErrorSnack(e.toString());
      },
    );
  }

  @override
  void onClose() {
    leavereasonTC.dispose();
    super.onClose();
  }
}
