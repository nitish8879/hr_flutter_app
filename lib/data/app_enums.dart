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
  wfh,
  paidLeave,
  casualAndSickLeave;

  String get readableName {
    return switch (this) {
      (wfh) => "Work From Home",
      (paidLeave) => "Paid Leave",
      (casualAndSickLeave) => "Casual/Sick Leave",
    };
  }

  String get code {
    return switch (this) {
      (wfh) => "WFH",
      (paidLeave) => "PAID_LEAVE",
      (casualAndSickLeave) => "CASUAL_AND_SICK_LEAVE",
    };
  }

  static List<String> get list {
    return [
      "Work From Home",
      "Paid Leave",
      "Casual/Sick Leave",
    ];
  }

  static LeaveType fromString(String val) {
    return switch (val) {
      ("Work From Home"||"WFH") => LeaveType.wfh,
      ("Paid Leave"||'PAID_LEAVE') => LeaveType.paidLeave,
      _ => LeaveType.casualAndSickLeave,
    };
  }
}
