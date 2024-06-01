class UserDataModel {
  int? userID;
  int? companyID;
  int? adminID;
  String? username;
  String? fullName;
  String? createdAt;
  String? roleType;
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
    roleType = json['roleType'];
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
    data['userID'] = this.userID;
    data['companyID'] = this.companyID;
    data['adminID'] = this.adminID;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['createdAt'] = this.createdAt;
    data['roleType'] = this.roleType;
    data['totalLeaveBalance'] = this.totalLeaveBalance;
    data['totalLeaveApproved'] = this.totalLeaveApproved;
    data['totalLeavePending'] = this.totalLeavePending;
    data['totalLeaveCancelled'] = this.totalLeaveCancelled;
    data['companyName'] = this.companyName;
    data['wrokingDays'] = this.wrokingDays;
    data['inTime'] = this.inTime;
    data['outTime'] = this.outTime;
    data['employeeApproved'] = this.employeeApproved;
    data['rejectedReason'] = this.rejectedReason;
    return data;
  }
}
