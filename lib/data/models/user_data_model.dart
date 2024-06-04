import 'package:hr_application/data/app_enums.dart';

class UserDataModel {
  String? userID;
  String? companyID;
  String? adminID;
  String? username;
  String? fullName;
  String? createdAt;
  UserRoleType? roleType;
  int? totalLeaveBalance;
  int? totalLeaveApproved;
  int? totalLeavePending;
  int? totalLeaveCancelled;
  String? companyName;
  List<String>? wrokingDays;
  String? inTime;
  String? outTime;
  bool? employeeApproved;
  String? rejectedReason;

  UserDataModel(
      {this.userID,
      this.companyID,
      this.adminID,
      this.username,
      this.fullName,
      this.createdAt,
      this.roleType,
      this.totalLeaveBalance,
      this.totalLeaveApproved,
      this.totalLeavePending,
      this.totalLeaveCancelled,
      this.companyName,
      this.wrokingDays,
      this.inTime,
      this.outTime,
      this.employeeApproved,
      this.rejectedReason});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    companyID = json['companyID'];
    adminID = json['adminID'];
    username = json['username'];
    fullName = json['fullName'];
    createdAt = json['createdAt'];
    if (json['roleType'] != null) {
      roleType = UserRoleType.fromString(json['roleType']);
    }
    totalLeaveBalance = json['totalLeaveBalance'];
    totalLeaveApproved = json['totalLeaveApproved'];
    totalLeavePending = json['totalLeavePending'];
    totalLeaveCancelled = json['totalLeaveCancelled'];
    companyName = json['companyName'];
    wrokingDays = (json['wrokingDays'])?.cast<String>();
    inTime = json['inTime'];
    outTime = json['outTime'];
    employeeApproved = json['employeeApproved'];
    rejectedReason = json['rejectedReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = userID;
    data['companyID'] = companyID;
    data['adminID'] = adminID;
    data['username'] = username;
    data['fullName'] = fullName;
    data['createdAt'] = createdAt;
    data['roleType'] = roleType?.code;
    data['totalLeaveBalance'] = totalLeaveBalance;
    data['totalLeaveApproved'] = totalLeaveApproved;
    data['totalLeavePending'] = totalLeavePending;
    data['totalLeaveCancelled'] = totalLeaveCancelled;
    data['companyName'] = companyName;
    data['wrokingDays'] = wrokingDays;
    data['inTime'] = inTime;
    data['outTime'] = outTime;
    data['employeeApproved'] = employeeApproved;
    data['rejectedReason'] = rejectedReason;
    return data;
  }
}
