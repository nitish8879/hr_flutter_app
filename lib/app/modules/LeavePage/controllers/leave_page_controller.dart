import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/models/teams_model.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_activity_model.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:hr_application/widgets/app_textfield.dart';

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
            "paidLeaveBalance": resp['data']['paidLeaveBalance'],
            "totalWFHbalance": resp['data']['totalWFHbalance'],
            "casualAndSickLeaveBalance": resp['data']
                ['casualAndSickLeaveBalance'],
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
        print(e.toString());
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

  Future<void> handleApproveRejectTap(
    LeaveActivityState status,
    LeaveActivityModel item,
  ) async {
    if (status == LeaveActivityState.rejected) {
      String rejectReason = "";
      Get.defaultDialog<void>(
        title: "Reject",
        content: AppTextField(
          hintText: "enter reject reason",
          onChanged: (a) => rejectReason = a,
        ),
        textCancel: "Cancel",
        textConfirm: "Update",
        onCancel: closeDialogs,
        onConfirm: () {
          if (rejectReason.trim().isEmpty) {
            showErrorSnack("Enter reject reason");
            return;
          }
          closeDialogs();
          updateLeave(status: status, item: item, rejectReason: rejectReason);
        },
      );
    } else {
      updateLeave(status: status, item: item);
    }
  }

  Future<void> updateLeave({
    required LeaveActivityState status,
    required LeaveActivityModel item,
    String? rejectReason,
  }) async {
    final resp = await ApiController.to.callPOSTAPI(
      url: APIUrlsService.to.approveRejectLeave,
      body: {
        "leaveID": item.id,
        "userID": AppStorageController.to.currentUser?.userID,
        "companyID": AppStorageController.to.currentUser?.companyID,
        "rejectReason": rejectReason,
        "leaveStatus": status.code,
        "employeeID": item.user?.id,
      },
    ).catchError(
      (e) {
        showErrorSnack(e.toString());
      },
    );
    if (resp != null && resp is Map<String, dynamic> && resp['status']) {
      getAllLeaves();
    } else {
      showErrorSnack(resp.toString());
    }
  }
}
