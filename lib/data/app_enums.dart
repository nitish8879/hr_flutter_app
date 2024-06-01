enum UserRoleType {
  superAdmin,
  admin,
  manager,
  watcher,
  employee;

  String get readableName {
    return switch (this) {
      (UserRoleType.superAdmin) => "Super Admin",
      (UserRoleType.admin) => "Admin",
      (UserRoleType.manager) => "Manager",
      (UserRoleType.watcher) => "Watcher",
      (UserRoleType.employee) => "Employee",
    };
  }

  static UserRoleType fromString(String val) {
    return switch (val.toLowerCase()) {
      "superadmin" => UserRoleType.superAdmin,
      "admin" => UserRoleType.admin,
      "manager" => UserRoleType.manager,
      "watcher" => UserRoleType.watcher,
      _ => UserRoleType.employee,
    };
  }
}
