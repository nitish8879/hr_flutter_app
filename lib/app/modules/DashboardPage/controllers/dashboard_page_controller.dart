import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/AllEmployesPage/bindings/all_employes_page_binding.dart';
import 'package:hr_application/app/modules/AllEmployesPage/views/all_employes_page_view.dart';
import 'package:hr_application/app/modules/HolidayPage/bindings/holiday_page_binding.dart';
import 'package:hr_application/app/modules/HolidayPage/views/holiday_page_view.dart';
import 'package:hr_application/app/modules/HomePage/bindings/home_page_binding.dart';
import 'package:hr_application/app/modules/HomePage/views/home_page_view.dart';
import 'package:hr_application/app/modules/LeavePage/bindings/leave_page_binding.dart';
import 'package:hr_application/app/modules/LeavePage/views/leave_page_view.dart';
import 'package:hr_application/app/modules/ProfilePage/bindings/profile_page_binding.dart';
import 'package:hr_application/app/modules/ProfilePage/views/profile_page_view.dart';
import 'package:hr_application/data/controllers/api_conntroller.dart';
import 'package:hr_application/data/controllers/api_url_service.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/helper_function.dart';

class DashboardPageController extends GetxController {
  List<Widget> pages = [];
  var currentIndex = 0.obs;

  Map<int, bool> canPageLoad = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false, // all team leave
  };
  @override
  void onInit() {
    super.onInit();
    canPageLoad[currentIndex.value] = true;
    HomePageBinding().dependencies();
    pages = [
      const HomePageView(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(),
    ];
  }

  onBottomNavTap(int newIndex) {
    print(newIndex);
    if (newIndex == currentIndex.value) return;
    if (!(canPageLoad[newIndex]!)) {
      canPageLoad[newIndex] = true;
      if (newIndex == 1) {
        pages.removeAt(newIndex);
        LeavePageBinding().dependencies();
        pages.insert(newIndex, const LeavePageView());
      }
      if (newIndex == 2) {
        pages.removeAt(newIndex);
        HolidayPageBinding().dependencies();
        pages.insert(newIndex, const HolidayPageView());
      }
      if (newIndex == 3) {
        pages.removeAt(newIndex);
        ProfilePageBinding().dependencies();
        pages.insert(newIndex, const ProfilePageView());
      }
    }
    currentIndex.value = newIndex;
  }

  void onFloatTap() {
    if (!(canPageLoad[4]!)) {
      pages.removeAt(4);
      AllEmployesPageBinding().dependencies();
      pages.insert(4, const AllEmployesPageView());
    }
    currentIndex.value = 4;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkUserIsApproved() {
    ApiController.to
        .callGETAPI(
      url: APIUrlsService.to.getDataByIDAndCompanyIdAndDate(
        AppStorageController.to.currentUser!.userID!,
        AppStorageController.to.currentUser!.companyID!,
        DateTime.now().toYYYMMDD,
      ),
    )
        .catchError((e) {
      showErrorSnack(e.toString());
    }).then((resp) async {
      if (resp is Map<String, dynamic> && resp['errorMsg'] != "Your account is not active") {
        AppStorageController.to.currentUser?.employeeApproved = true;
        AppStorageController.to.saveUserData(AppStorageController.to.currentUser!.toJson());
        update(['rootUI']);
      } else {
        showErrorSnack(resp['errorMsg'].toString());
      }
      print(resp);
    });
  }
}
