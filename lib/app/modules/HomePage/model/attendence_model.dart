class AttendenceModel {
  int? id;
  int? userID;
  int? companyID;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['companyID'] = this.companyID;
    data['inTime'] = this.inTime;
    data['outTime'] = this.outTime;
    data['breakInTimes'] = this.breakInTime;
    data['breakOutTimes'] = this.breakOutTime;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
