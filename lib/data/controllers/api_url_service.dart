import 'package:get/get.dart';

class APIUrlsService extends GetxService {
  static APIUrlsService to = Get.isRegistered<APIUrlsService>() ? Get.find<APIUrlsService>() : Get.put(APIUrlsService());
  final String baseURL = "http://10.0.2.2:1010/";

  final String login = "auth/signin";
  final String signup = "auth/signup";
  final String dailyInOut = "activity/dailyInOut";
  final String addLeave = "leave/addLeave";
  String allEmployeeByCompany(int compnayID) => "auth/allEmployees/$compnayID";
  String allHolidayByCompanyID(int compnayID) => "company/getHoliday?companyId=$compnayID";

  String getTotalCountLeave(
    int userID,
    int compnayID,
  ) =>
      "auth/getTotalLeave?userID=$userID&companyID=$compnayID";
  String getTotalLeaves(
    int userID,
    int compnayID,
  ) =>
      "leave/getAllLeaves?userID=$userID&companyID=$compnayID";
  String getDataByIDAndCompanyIdAndDate(
    int id,
    int compnayID,
    String date,
  ) =>
      "activity/getDataByIDAndCompanyIdAndDate?id=$id&compnayID=$compnayID&date=$date";
  String getActivityList(
    int id,
    int compnayID,
    String date,
  ) =>
      "activity/getActivityList?id=$id&compnayID=$compnayID&date=$date";
}
