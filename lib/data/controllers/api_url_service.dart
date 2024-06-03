import 'package:get/get.dart';

class APIUrlsService extends GetxService {
  static APIUrlsService to = Get.isRegistered<APIUrlsService>() ? Get.find<APIUrlsService>() : Get.put(APIUrlsService());
  // final String baseURL = "http://10.0.2.2:1010/"; //for App localhost
  final String baseURL = "http://127.0.0.1:1010/"; // for web app localhost

  final String login = "auth/signin";
  final String signup = "auth/signup";
  final String dailyInOut = "activity/dailyInOut";
  final String addLeave = "leave/addLeave";
  String allEmployeeByCompany(String compnayID) => "auth/allEmployees/$compnayID";
  String allHolidayByCompanyID(String compnayID) => "company/getHoliday?companyId=$compnayID";

  String getTotalCountLeave(
    String userID,
    String compnayID,
  ) =>
      "auth/getTotalLeave?userID=$userID&companyID=$compnayID";
  String getTotalLeaves(
    String userID,
    String compnayID,
  ) =>
      "leave/getAllLeaves?userID=$userID&companyID=$compnayID";
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
}
