import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSuccessSnack(String msg) {
  Get.closeAllSnackbars();
  Get.snackbar("Success", msg, messageText: Text(msg, maxLines: 4));
}

final workingDaysMapping = <String, int>{
  "MONDAY": 1,
  "TUESDAY": 2,
  "WEDNESDAY": 3,
  "THURSDAY": 4,
  "FRIDAY": 5,
  "SATURDAY": 6,
  "SUNDAY": 7,
};

showErrorSnack(String msg) {
  Get.closeAllSnackbars();
  Get.snackbar("Error", msg, messageText: Text(msg, maxLines: 4));
}

closeDialogs() {
  Get.back();
}

List<int> workingDays(List<String> days) {
  List<int> workingDays = [];
  for (var element in days) {
    if (workingDaysMapping.containsKey(element)) {
      workingDays.add(workingDaysMapping[element]!);
    }
  }
  return workingDays;
}

String secondsToTime(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = seconds % 60;

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  String formattedTime =
      "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(remainingSeconds)}";

  return formattedTime;
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  int seconds = 0;
  String formattedTime = "${twoDigits(timeOfDay.hour)}:"
      "${twoDigits(timeOfDay.minute)}:"
      "${twoDigits(seconds)}";

  return formattedTime;
}

List<String> mergeBreakInBreakOutTimes(
    List<String> inTimes, List<String> outTimes) {
  List<String> mergedTimes = [];
  int maxLength =
      inTimes.length > outTimes.length ? inTimes.length : outTimes.length;

  for (int i = 0; i < maxLength; i++) {
    if (i < inTimes.length) {
      mergedTimes.add(inTimes[i]);
    }
    if (i < outTimes.length) {
      mergedTimes.add(outTimes[i]);
    }
  }

  return mergedTimes;
}
