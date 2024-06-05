import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/models/teams_model.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';

class ApplyLeavePageController extends GetxController {
  var leavereasonTC = TextEditingController();
  var leaveStartDate = Rxn<DateTime?>(), leaveEndDate = Rxn<DateTime?>();
  var teams = <TeamsModel>[];
  TeamsModel? selectedTeam;
  var isTeamLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchAllTeams();
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
      } else {
        showErrorSnack((resp['errorMsg'] ?? resp).toString());
      }
    });
  }

  Future<void> fetchAllTeams() async {
    if (!isTeamLoading.value) {
      isTeamLoading.value = true;
    }
    final resp = await ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.fetchTeams(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
        AppStorageController.to.currentUser!.roleType!.code,
      ),
    )
        .catchError((e) {
      isTeamLoading.value = true;
    });
    if (resp != null && resp is List<dynamic>) {
      teams.clear();
      teams.addAll(
        (resp).map((e) => TeamsModel.fromJson(e)).toList(),
      );
      if (teams.isNotEmpty) {
        selectedTeam = teams.first;
      }
      isTeamLoading.value = false;
    } else {
      showErrorSnack((resp['errorMsg'] ?? resp).toString());
    }
  }

  @override
  void onClose() {}
}
