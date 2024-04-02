enum UserRoleType {
  admin,
  manager,
  watcher,
  employee;

  String get readableName {
    return switch (this) {
      (UserRoleType.admin) => "Admin",
      (UserRoleType.manager) => "Manager",
      (UserRoleType.watcher) => "Watcher",
      (UserRoleType.employee) => "Employee",
    };
  }

  static UserRoleType fromString(String val) {
    return switch (val.toLowerCase()) {
      "admin" => UserRoleType.admin,
      "manager" => UserRoleType.manager,
      "watcher" => UserRoleType.watcher,
      _ => UserRoleType.employee,
    };
  }
}
