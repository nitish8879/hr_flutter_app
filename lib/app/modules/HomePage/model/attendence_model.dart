class AttendenceModel {
  String? id;
  String? userID;
  String? companyID;
  String? inTime;
  String? outTime;
  List<String>? breakInTime;
  List<String>? breakOutTime;
  String? createdAt;

  AttendenceModel({
    this.id,
    this.userID,
    this.companyID,
    this.inTime,
    this.outTime,
    this.breakInTime,
    this.breakOutTime,
    this.createdAt,
  });

  AttendenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    companyID = json['companyID'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    if (json['breakInTimes'] != null) {
      breakInTime = json['breakInTimes'].cast<String>();
    }
    if (json['breakOutTimes'] != null) {
      breakOutTime = json['breakOutTimes'].cast<String>();
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['companyID'] = companyID;
    data['inTime'] = inTime;
    data['outTime'] = outTime;
    data['breakInTimes'] = breakInTime;
    data['breakOutTimes'] = breakOutTime;
    data['createdAt'] = createdAt;
    return data;
  }
}
