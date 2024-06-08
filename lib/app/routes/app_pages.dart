import 'package:get/get.dart';

import 'package:hr_application/app/modules/ApplyLeavePage/bindings/apply_leave_page_binding.dart';
import 'package:hr_application/app/modules/ApplyLeavePage/views/apply_leave_page_view.dart';
import 'package:hr_application/app/modules/HomeAnalytics/bindings/home_analytics_binding.dart';
import 'package:hr_application/app/modules/HomeAnalytics/views/home_analytics_view.dart';

import '../modules/AllEmployesPage/bindings/all_employes_page_binding.dart';
import '../modules/AllEmployesPage/views/all_employes_page_view.dart';
import '../modules/DashboardPage/bindings/dashboard_page_binding.dart';
import '../modules/DashboardPage/views/dashboard_page_view.dart';
import '../modules/HolidayPage/bindings/holiday_page_binding.dart';
import '../modules/HolidayPage/views/holiday_page_view.dart';
import '../modules/HomePage/bindings/home_page_binding.dart';
import '../modules/HomePage/views/home_page_view.dart';
import '../modules/LeavePage/bindings/leave_page_binding.dart';
import '../modules/LeavePage/views/leave_page_view.dart';
import '../modules/LoginPage/bindings/login_page_binding.dart';
import '../modules/LoginPage/views/login_page_view.dart';
import '../modules/ProfilePage/bindings/profile_page_binding.dart';
import '../modules/ProfilePage/views/profile_page_view.dart';
import '../modules/SignUpPage/bindings/sign_up_page_binding.dart';
import '../modules/SignUpPage/views/sign_up_page_view.dart';
import '../modules/SplashScreenPage/bindings/splash_screen_page_binding.dart';
import '../modules/SplashScreenPage/views/splash_screen_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN_PAGE,
      page: () => const SplashScreenPageView(),
      binding: SplashScreenPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_PAGE,
      page: () => const SignUpPageView(),
      binding: SignUpPageBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_PAGE,
      page: () => const DashboardPageView(),
      binding: DashboardPageBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_PAGE,
      page: () => const LeavePageView(),
      binding: LeavePageBinding(),
    ),
    GetPage(
      name: _Paths.HOLIDAY_PAGE,
      page: () => const HolidayPageView(),
      binding: HolidayPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.ALL_EMPLOYES_PAGE,
      page: () => const AllEmployesPageView(),
      binding: AllEmployesPageBinding(),
    ),
    GetPage(
      name: _Paths.APPLY_LEAVE_PAGE,
      page: () => ApplyLeavePageView(),
      binding: ApplyLeavePageBinding(),
    ),
    GetPage(
      name: _Paths.HOME_ANALYTICS,
      page: () => HomeAnalyticsView(),
      binding: HomeAnalyticsBinding(),
    ),
  ];
}
