class MemberModel {
  MembersData? manager;
  List<MembersData>? members;

  MemberModel({this.manager, this.members});

  MemberModel.fromJson(Map<String, dynamic> json) {
    manager = json['manager'] != null
        ? new MembersData.fromJson(json['manager'])
        : null;
    if (json['members'] != null) {
      members = <MembersData>[];
      json['members'].forEach((v) {
        members!.add(new MembersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.manager != null) {
      data['manager'] = this.manager!.toJson();
    }
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MembersData {
  String? id;
  String? userName;
  String? fullName;
  String? createdAt;
  String? roleType;

  MembersData(
      {this.id, this.userName, this.fullName, this.createdAt, this.roleType});

  MembersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];
    createdAt = json['createdAt'];
    roleType = json['roleType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['createdAt'] = this.createdAt;
    data['roleType'] = this.roleType;
    return data;
  }
}
