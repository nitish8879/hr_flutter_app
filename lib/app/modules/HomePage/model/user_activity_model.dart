class UserActivityModel {
  BreakOutTime? breakOutTime;
  int? activityID;
  CheckIn? checkIn;
  BreakInTime? breakInTime;
  OutTime? outTime;

  UserActivityModel({this.breakOutTime, this.activityID, this.checkIn, this.breakInTime, this.outTime});

  UserActivityModel.fromJson(Map<String, dynamic> json) {
    breakOutTime = json['breakOutTime'] != null ? new BreakOutTime.fromJson(json['breakOutTime']) : null;
    activityID = json['activityID'];
    checkIn = json['checkIn'] != null ? new CheckIn.fromJson(json['checkIn']) : null;
    breakInTime = json['breakInTime'] != null ? new BreakInTime.fromJson(json['breakInTime']) : null;
    outTime = json['outTime'] != null ? new OutTime.fromJson(json['outTime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breakOutTime != null) {
      data['breakOutTime'] = this.breakOutTime!.toJson();
    }
    data['activityID'] = this.activityID;
    if (this.checkIn != null) {
      data['checkIn'] = this.checkIn!.toJson();
    }
    if (this.breakInTime != null) {
      data['breakInTime'] = this.breakInTime!.toJson();
    }
    if (this.outTime != null) {
      data['outTime'] = this.outTime!.toJson();
    }
    return data;
  }
}

class BreakOutTime {
  String? breakOutTime;
  String? date;

  BreakOutTime({this.breakOutTime, this.date});

  BreakOutTime.fromJson(Map<String, dynamic> json) {
    breakOutTime = json['breakOutTime'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breakOutTime'] = this.breakOutTime;
    data['date'] = this.date;
    return data;
  }
}

class CheckIn {
  String? inTime;
  String? date;
  String? msg;

  CheckIn({this.inTime, this.date, this.msg});

  CheckIn.fromJson(Map<String, dynamic> json) {
    inTime = json['inTime'];
    date = json['date'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inTime'] = this.inTime;
    data['date'] = this.date;
    data['msg'] = this.msg;
    return data;
  }
}

class BreakInTime {
  String? date;
  String? breakInTime;

  BreakInTime({this.date, this.breakInTime});

  BreakInTime.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    breakInTime = json['breakInTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['breakInTime'] = this.breakInTime;
    return data;
  }
}

class OutTime {
  String? date;
  String? msg;
  String? outTime;

  OutTime({this.date, this.msg, this.outTime});

  OutTime.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    msg = json['msg'];
    outTime = json['outTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['msg'] = this.msg;
    data['outTime'] = this.outTime;
    return data;
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
