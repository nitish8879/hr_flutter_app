class UserActivityModel {
  List<BreakOutTime>? breakOutTime;
  List<BreakInTime>? breakInTime;
  int? activityID;
  CheckIn? checkIn;
  OutTime? outTime;
  String? createdAt;

  UserActivityModel({
    this.breakOutTime,
    this.activityID,
    this.checkIn,
    this.breakInTime,
    this.outTime,
    this.createdAt,
  });

  UserActivityModel.fromJson(Map<String, dynamic> json) {
    activityID = json['activityID'];
    createdAt = json['date'];
    checkIn =
        json['checkIn'] != null ? CheckIn.fromJson(json['checkIn']) : null;
    outTime =
        json['outTime'] != null ? OutTime.fromJson(json['outTime']) : null;

    if (json['breakOutTime'] != null) {
      breakOutTime = [];
      for (var v in (json['breakOutTime'] as List<dynamic>)) {
        breakOutTime?.add(BreakOutTime.fromJson(v));
      }
    }
    if (json['breakInTime'] != null) {
      breakInTime = [];
      for (var v in (json['breakInTime'] as List<dynamic>)) {
        breakInTime?.add(BreakInTime.fromJson(v));
      }
    }
  }
}

class BreakOutTime {
  String? breakOutTime;

  BreakOutTime({this.breakOutTime});

  BreakOutTime.fromJson(Map<String, dynamic> json) {
    breakOutTime = json['breakOutTime'];
  }
}

class BreakInTime {
  String? breakInTime;

  BreakInTime({this.breakInTime});

  BreakInTime.fromJson(Map<String, dynamic> json) {
    breakInTime = json['breakInTime'];
  }
}

class CheckIn {
  String? inTime;
  String? msg;

  CheckIn({this.inTime, this.msg});

  CheckIn.fromJson(Map<String, dynamic> json) {
    inTime = json['inTime'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['inTime'] = this.inTime;
    data['msg'] = this.msg;
    return data;
  }
}

class OutTime {
  String? msg;
  String? outTime;

  OutTime({this.msg, this.outTime});

  OutTime.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    outTime = json['outTime'];
  }
}

enum UserPerformActivty {
  IN,
  OUT,
  BREAKIN,
  BREAKOUT; //name => BREAKOUT

  String get label {
    return switch (this) {
      (IN) => "Swipe to Check in.",
      (BREAKIN) => "Swipe to Break in.",
      (BREAKOUT) => "Swipe to Break out.",
      (OUT) => "Swipe to Check out.",
    };
  }
}
