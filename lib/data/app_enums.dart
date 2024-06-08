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

  String get code {
    return switch (this) {
      (UserRoleType.superAdmin) => "SUPERADMIN",
      (UserRoleType.admin) => "ADMIN",
      (UserRoleType.manager) => "MANAGER",
      (UserRoleType.watcher) => "WATCHER",
      (UserRoleType.employee) => "EMPLOYEE",
    };
  }

  static List<String> get list {
    return [
      UserRoleType.superAdmin.code,
      UserRoleType.admin.code,
      UserRoleType.manager.code,
      UserRoleType.watcher.code,
      UserRoleType.employee.code,
    ];
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

enum LeaveType {
  WFH,
  ONEDAY,
  MANYDAYS;

  String get readableName {
    return switch (this) {
      (WFH) => "Work From Home",
      (ONEDAY) => "One Day",
      (MANYDAYS) => "Many Days",
    };
  }

  String get code {
    return switch (this) {
      (WFH) => "WFH",
      (ONEDAY) => "ONEDAY",
      (MANYDAYS) => "MANYDAYS",
    };
  }

  static List<String> get list {
    return [
      "Work From Home",
      "One Day",
      "Many Days",
    ];
  }

  static LeaveType fromString(String val) {
    return switch (val) {
      "Work From Home" => LeaveType.WFH,
      "One Day" => LeaveType.ONEDAY,
      _ => LeaveType.MANYDAYS,
    };
  }
}
