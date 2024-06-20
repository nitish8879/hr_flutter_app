
import 'package:flutter/material.dart';
import 'package:hr_application/app/models/team_members_model.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:intl/intl.dart';

class LeaveActivityModel {
  String? id;
  String? userID;
  String? companyID;
  MembersData? approvalTo;
  DateTime? applyDate;
  LeaveActivityState? leaveStatus;
  DateTime? fromdate;
  DateTime? todate;
  String? leaveReason;
  String? rejectedReason;
  MembersData? user;

  LeaveActivityModel({
    this.id,
    this.userID,
    this.companyID,
    this.approvalTo,
    this.applyDate,
    this.leaveStatus,
    this.fromdate,
    this.todate,
    this.leaveReason,
    this.rejectedReason,
    this.user,
  });

  LeaveActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    companyID = json['companyID'];
    if (json['user'] != null) {
      user = MembersData.fromJson(json['user']);
    }
    if (json['approvalTo'] != null) {
      approvalTo = MembersData.fromJson(json['approvalTo']);
    }
    leaveStatus = LeaveActivityState.fromStrings(json['leaveStatus']);

    if (json['fromdate'] != null) {
      fromdate = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json['fromdate']);
    }
    if (json['todate'] != null) {
      todate = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(json['todate']);
    }
    if (json['applyDate'] != null) {
      applyDate = DateFormat("yyyy-MM-dd").parse(json['applyDate']);
    }
    leaveReason = json['leaveReason'];
    rejectedReason = json['rejectedReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userID'] = userID;
    data['companyID'] = companyID;
    data['approvalTo'] = approvalTo;
    data['applyDate'] = applyDate;
    data['leaveStatus'] = leaveStatus;
    data['fromdate'] = fromdate;
    data['todate'] = todate;
    data['leaveReason'] = leaveReason;
    data['rejectedReason'] = rejectedReason;
    return data;
  }
}

enum LeaveActivityState {
  pending,
  approved,
  rejected;

  static List<String> get list {
    return [
      "Pending",
      "Approved",
      "Rejected",
    ];
  }

  static LeaveActivityState? fromStrings(String val) {
    switch (val.toUpperCase()) {
      case ("PENDING"):
        return LeaveActivityState.pending;
      case ("APPROVED"):
        return LeaveActivityState.approved;
      case ("REJECTED"):
        return LeaveActivityState.rejected;
    }
    return null;
  }

  String get code {
    return switch (this) {
      (pending) => "PENDING",
      (approved) => "APPROVED",
      (rejected) => "REJECTED",
    };
  }

  String get getName {
    return switch (this) {
      (pending) => "Pending",
      (approved) => "Approved",
      (rejected) => "Rejecetd",
    };
  }

  Color get getColor {
    return switch (this) {
      (pending) => (AppColors.kFoundationPurple700),
      (approved) => (AppColors.kGreen700),
      (rejected) => (AppColors.kFailureRed),
    };
  }
}
