import 'package:get/get.dart';
import 'package:hr_application/app/modules/HomePage/model/attendence_model.dart';
import 'package:hr_application/app/modules/HomePage/model/user_activity_model.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var attendenceLoading = true.obs, activityLoading = true.obs;
  var attendenceModel = Rxn<AttendenceModel?>(null);
  var userActivityModel = Rxn<UserActivityModel?>(null);
  var userPerformActivty = UserPerformActivty.IN.obs;
  var now = DateTime.now();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getTodatyAttendenceData();
    getActivityData();
    print(AppStorageController.to.currentUser?.toJson());
  }

  void onDateChnged(DateTime newDate) {
    selectedDate.value = newDate;
    print(selectedDate.toString());
    getTodatyAttendenceData();
    getActivityData();
  }

  void getTodatyAttendenceData() {
    var url = APIUrlsService.to.getDataByIDAndCompanyIdAndDate(
      AppStorageController.to.currentUser!.userID!,
      AppStorageController.to.currentUser!.companyID!,
      selectedDate.value.toYYYMMDD,
    );
    ApiController.to
        .callGETAPI(
      url: url,
    )
        .catchError((e) {
      showErrorSnack(e.toString());
      attendenceLoading.value = false;
    }).then((resp) {
      attendenceLoading.value = false;
      if (resp != null && resp is Map<String, dynamic> && (resp['status'] as bool)) {
        attendenceModel.value = AttendenceModel.fromJson(resp['data']);
      } else {
        attendenceModel.value = null;
      }
      print("getTodatyAttendenceData$resp");
    });
  }

  void getActivityData() {
    ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.getActivityList(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
        selectedDate.value.toYYYMMDD,
      ),
    )
        .catchError((e) {
      showErrorSnack(e.toString());
      activityLoading.value = false;
    }).then((resp) {
      activityLoading.value = false;
      if (resp != null && resp is Map<String, dynamic> && resp['data'] != null) {
        userActivityModel.value = UserActivityModel.fromJson(resp['data']);
        if (userActivityModel.value?.checkIn == null) {
          userPerformActivty.value = UserPerformActivty.IN;
        } else if (userActivityModel.value?.breakInTime == null) {
          userPerformActivty.value = UserPerformActivty.BREAKIN;
        } else if (userActivityModel.value?.breakOutTime == null) {
          userPerformActivty.value = UserPerformActivty.BREAKOUT;
        } else {
          userPerformActivty.value = UserPerformActivty.OUT;
        }
      } else {
        userActivityModel.value = null;
      }
      print("getActivityData$resp");
    });
  }

  void performInOut() {
    if (activityLoading.value) return;
    activityLoading.value = true;
    var payload = {
      "activityID": userActivityModel.value?.activityID,
      "userID": AppStorageController.to.currentUser?.userID,
      "companyID": AppStorageController.to.currentUser?.companyID,
      "activityType": userPerformActivty.value.name,
    };
    if (userPerformActivty.value == UserPerformActivty.IN) {
      payload.putIfAbsent("inTime", () => DateTime.now().toHOUR24MINUTESECOND);
    } else if (userPerformActivty.value == UserPerformActivty.BREAKIN) {
      payload.putIfAbsent("breakInTime", () => DateTime.now().toHOUR24MINUTESECOND);
    } else if (userPerformActivty.value == UserPerformActivty.BREAKOUT) {
      payload.putIfAbsent("breakOutTime", () => DateTime.now().toHOUR24MINUTESECOND);
    } else if (userPerformActivty.value == UserPerformActivty.OUT) {
      payload.putIfAbsent("outTime", () => DateTime.now().toHOUR24MINUTESECOND);
    }
    print(payload);
    ApiController.to
        .callPOSTAPI(
      url: APIUrlsService.to.dailyInOut,
      body: payload,
    )
        .catchError((e) {
      activityLoading.value = false;
      // showErrorSnack(e.toString());
      print("performInOut$e");
    }).then((resp) {
      activityLoading.value = false;
      if (resp != null && resp is Map<String, dynamic> && resp['status']) {
        getTodatyAttendenceData();
        getActivityData();
        showSuccessSnack("User has been: ${userPerformActivty.value.name}");
      }
      print("performInOut$resp");
    });
  }

  String? calculateTimeDifference(String? timeString1, String? timeString2) {
    if (timeString1 == null || timeString2 == null) {
      return null;
    }

    // Parse time strings
    DateFormat timeFormat = DateFormat("HH:mm:ss");
    DateTime time1 = timeFormat.parse(timeString1);
    DateTime time2 = timeFormat.parse(timeString2);

    // Calculate time difference
    Duration difference = time1.difference(time2);

    // Get hours and minutes from the duration
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    // Format the difference
    return "${hours.abs().toString().padLeft(2, '0')}:${minutes.abs().toString().padLeft(2, '0')} min";
  }

  @override
  void onClose() {
    super.onClose();
  }

  int get countWorkingDays {
    int count = 0;
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;

    int totalDaysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;

    for (int day = 1; day <= totalDaysInMonth; day++) {
      var currentDate = DateTime(currentYear, currentMonth, day).toWEEKDAY;
      if (AppStorageController.to.currentUser!.wrokingDays!.contains(currentDate.toUpperCase())) {
        count++;
      }
    }

    return count;
  }
}
