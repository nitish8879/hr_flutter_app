import 'package:get/get.dart';

class APIUrlsService extends GetxService {
  static APIUrlsService to = Get.isRegistered<APIUrlsService>()
      ? Get.find<APIUrlsService>()
      : Get.put(APIUrlsService());
  // final String baseURL = "http://10.0.2.2:1010/"; //for App localhost
  final String baseURL = "http://127.0.0.1:1010/"; // for web app localhost

  ////////// ?? AUTH          ??/////////////
  final String login = "auth/signin";
  final String signup = "auth/signup";
  String updatePassword(
          String username, String oldpassword, String reenterPassword) =>
      "auth/updatePassword?username=$username&oldpassword=$oldpassword&newpassword=$reenterPassword";

  //////////////////?? Home Page API     ??////////////////
  final String dailyInOut = "activity/dailyInOut";

  String getDataByIDAndCompanyIdAndDate(
    String id,
    String compnayID,
    String date,
  ) =>
      "activity/getDataByIDAndCompanyIdAndDate?id=$id&compnayID=$compnayID&date=$date";
  String getActivityList(
    String id,
    String compnayID,
    String date,
  ) =>
      "activity/getActivityList?id=$id&compnayID=$compnayID&date=$date";

  //////////////?? HOLIDAY   ??/////////////
  String allHolidayByCompanyID(String compnayID) =>
      "company/getHoliday?companyId=$compnayID";

  ////////// ?? Leave ??///////////////////
  final String addLeave = "leave/addLeave";

  String getTotalCountLeave(
    String userID,
    String compnayID,
  ) =>
      "auth/getTotalLeave?userID=$userID&companyID=$compnayID";

  String approveRejectLeave(
    String userID,
    String compnayID,
    String employeeID,
    String leaveID,
    String rejectReason,
    String leaveStatus,
  ) =>
      "auth/approveReject?userID=$userID&companyID=$compnayID&leaveID=$leaveID&employeeID=$employeeID&rejectReason$rejectReason";
  String getAllLeaves(
          String userID, String compnayID, String roleType, bool myLeave) =>
      "leave/getAllLeaves?userID=$userID&companyID=$compnayID&roleType=$roleType&myLeave=$myLeave";

  ////////////////////??     TEAMS              ??/////////////////
  String get addTeam => "team/add";

  String get addMember => "team/add/member";

  String fetchAllAdminManagerByCompany(String companyID, String userID) =>
      "team/fetchAllAdminManagerByCompany?companyID=$companyID&userId=$userID";

  String fetchTeams(String userID, String companyID, String roleType) =>
      "team/fetchTeams?userID=$userID&companyID=$companyID&roleType=$roleType";

  String fetchMembers(String userID, String companyID, String teamID) =>
      "team/fetchMembers?userID=$userID&companyID=$companyID&teamID=$teamID";
}
