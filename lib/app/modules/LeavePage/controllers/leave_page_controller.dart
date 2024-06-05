import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/models/teams_model.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_activity_model.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';

class LeavePageController extends GetxController {
  var tabSelected = Rxn(LeaveActivityState.pending);
  var leaveActivities = <LeaveActivityModel>[].obs;
  var mainList = <LeaveActivityModel>[];
  var leavereasonTC = TextEditingController();
  var leaveStartDate = Rxn<DateTime?>(), leaveEndDate = Rxn<DateTime?>();
  var totalCount = {}.obs;
  var myData = false.obs;
  var isTeamLoading = true.obs;
  var teams = <TeamsModel>[];
  TeamsModel? selectedTeam;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getAllLeaves();
  }

  void onTabChange(LeaveActivityState newState) {
    // if (newState == tabSelected.value) return;
    leaveActivities.clear();
    leaveActivities
        .addAll(mainList.where((element) => element.leaveStatus == newState));
    print(leaveActivities.length);
    tabSelected.value = newState;
  }

  Future<void> fetchAllTeams() async {
    if (!isTeamLoading.value) {
      isTeamLoading.value = true;
    }
    await AppStorageController.to.asyncCurrentUser;
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
        getAllLeaves();
      } else {
        showErrorSnack((resp['errorMsg'] ?? resp).toString());
      }
    });
  }

  void getAllLeaves() {
    ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.getAllLeaves(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
        AppStorageController.to.currentUser!.roleType!.code,
        myData.value,
      ),
    )
        .then((resp) {
      leaveActivities.clear();
      mainList.clear();
      if (resp != null && resp['status']) {
        if (resp['data'] is List<dynamic>) {
          totalCount.value = {};
          mainList.addAll(
            (resp['data'] as List<dynamic>)
                .map((e) => LeaveActivityModel.fromJson(e))
                .toList(),
          );
        } else {
          totalCount.value = {
            "totalLeavebalance": resp['totalLeavebalance'],
            "totalWFHbalance": resp['totalWFHbalance'],
          };
          mainList.addAll(
            (resp['data']['data'] as List<dynamic>)
                .map((e) => LeaveActivityModel.fromJson(e))
                .toList(),
          );
        }
        onTabChange(LeaveActivityState.pending);
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

  void myDataChanged(bool value) {
    myData.value = value;
    getAllLeaves();
  }
}
