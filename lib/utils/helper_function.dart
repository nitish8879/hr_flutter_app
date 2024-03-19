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
