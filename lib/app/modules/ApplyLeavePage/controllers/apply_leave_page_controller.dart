import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/models/team_members_model.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';

class ApplyLeavePageController extends GetxController {
  var leavereasonTC = TextEditingController();
  var leaveStartDate = Rxn<DateTime?>(), leaveEndDate = Rxn<DateTime?>();
  var adminMembers = <MembersData>[];
  MembersData? selectedTeam;
  LeaveType? selectedLeaveType;
  var isTeamLoading = true.obs;
  // bool canShowToDate = true;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchAllAdminMembers();
  }

  void goBack() {
    if (Get.previousRoute.isEmpty) {
      Get.offAllNamed(AppPages.INITIAL);
    } else {
      Get.back();
    }
  }

  void appllyLeave() {
    if (selectedTeam == null || leavereasonTC.text.trim().isEmpty || selectedLeaveType == null) {
      showErrorSnack("Select Approval Person and enter leave reason and select Leave Type");
      return;
    }
    ApiController.to.callPOSTAPI(
      url: APIUrlsService.to.addLeave,
      body: {
        "userID": AppStorageController.to.currentUser?.userID,
        "companyID": AppStorageController.to.currentUser?.companyID,
        "approvalTo": selectedTeam?.id,
        "leaveStatus": "PENDING",
        "fromdate": leaveStartDate.value?.toDDMMYYYY,
        "todate": leaveEndDate.value?.toDDMMYYYY,
        "leaveReason": leavereasonTC.text,
        "leaveType": selectedLeaveType?.code,
      },
    ).then((resp) {
      if (resp != null && resp is Map<String, dynamic> && resp['status']) {
        leavereasonTC.clear();
        leaveStartDate.value = null;
        leaveEndDate.value = null;
        goBack();
      } else {
        showErrorSnack((resp['errorMsg'] ?? resp).toString());
      }
    });
  }

  Future<void> fetchAllAdminMembers() async {
    if (!isTeamLoading.value) {
      isTeamLoading.value = true;
    }
    final resp = await ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.fetchAllAdminManagerByCompany(
        AppStorageController.to.currentUser!.companyID!,
        AppStorageController.to.currentUser!.userID!,
      ),
    )
        .catchError((e) {
      isTeamLoading.value = true;
    });
    if (resp != null && resp is List<dynamic>) {
      adminMembers.clear();
      adminMembers.addAll(
        (resp).map((e) => MembersData.fromJson(e)).toList(),
      );
      if (adminMembers.isNotEmpty) {
        selectedTeam = adminMembers.first;
      }
      isTeamLoading.value = false;
    } else {
      showErrorSnack((resp['errorMsg'] ?? resp).toString());
    }
  }

  @override
  void onClose() {}
}
