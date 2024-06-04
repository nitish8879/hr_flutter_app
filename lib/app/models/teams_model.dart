class TeamsModel {
  String? id;
  String? createdAt;
  String? teamName;

  TeamsModel({this.id, this.createdAt, this.teamName});

  TeamsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    teamName = json['teamName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['teamName'] = this.teamName;
    return data;
  }
}
