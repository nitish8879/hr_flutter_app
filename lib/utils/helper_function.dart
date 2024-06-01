import 'package:get/get.dart';

showSuccessSnack(String msg) {
  Get.closeAllSnackbars();
  Get.snackbar(
    "Success",
    msg,
  );
}

showErrorSnack(String msg) {
  Get.closeAllSnackbars();
  Get.snackbar(
    "Error",
    msg,
  );
}

String secondsToTime(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = seconds % 60;

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  String formattedTime = "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(remainingSeconds)}";

  return formattedTime;
}

List<String> mergeBreakInBreakOutTimes(List<String> inTimes, List<String> outTimes) {
  List<String> mergedTimes = [];
  int maxLength = inTimes.length > outTimes.length ? inTimes.length : outTimes.length;

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
