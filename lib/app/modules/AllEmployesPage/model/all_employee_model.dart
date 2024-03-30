class AllEmployeeModel {
  String? createdAt;
  String? role;
  String? name;
  int? id;
  String? username;
  bool? status;

  AllEmployeeModel({this.createdAt, this.role, this.name, this.id, this.username, this.status});

  AllEmployeeModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    role = json['role'];
    name = json['name'];
    id = json['id'];
    username = json['username'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['role'] = this.role;
    data['name'] = this.name;
    data['id'] = this.id;
    data['username'] = this.username;
    data['status'] = this.status;
    return data;
  }
}
