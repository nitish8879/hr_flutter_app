import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/intial_binding.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      theme: appTheme,
      initialBinding: IntialBinding(),
    ),
  );
}
