import 'package:get/get.dart';

class APIUrlsService extends GetxService {
  static APIUrlsService to = Get.isRegistered<APIUrlsService>() ? Get.find<APIUrlsService>() : Get.put(APIUrlsService());
  final String baseURL = "http://10.0.2.2:1010/";

  final String login = "auth/signin";
  final String signup = "auth/signup";
  final String dailyInOut = "activity/dailyInOut";
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
