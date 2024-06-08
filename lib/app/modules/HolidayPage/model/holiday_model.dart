class HolidayModel {
  String? id;
  String? holidayDate;
  String? label;

  HolidayModel({this.id, this.holidayDate, this.label});

  HolidayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holidayDate = json['holidayDate'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['holidayDate'] = this.holidayDate;
    data['label'] = this.label;
    return data;
  }
}
