class LeaveTotalCountModel {
  int? totalLeaveCancelled;
  int? totalLeaveApproved;
  int? totalLeaveBalance;
  int? totalLeavePending;

  LeaveTotalCountModel({this.totalLeaveCancelled, this.totalLeaveApproved, this.totalLeaveBalance, this.totalLeavePending});

  LeaveTotalCountModel.fromJson(Map<String, dynamic> json) {
    totalLeaveCancelled = json['totalLeaveCancelled'];
    totalLeaveApproved = json['totalLeaveApproved'];
    totalLeaveBalance = json['totalLeaveBalance'];
    totalLeavePending = json['totalLeavePending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalLeaveCancelled'] = this.totalLeaveCancelled;
    data['totalLeaveApproved'] = this.totalLeaveApproved;
    data['totalLeaveBalance'] = this.totalLeaveBalance;
    data['totalLeavePending'] = this.totalLeavePending;
    return data;
  }
}
