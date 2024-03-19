import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_page_controller.dart';

class SplashScreenPageView extends GetView<SplashScreenPageController> {
  const SplashScreenPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          controller.appImageLogo,
          width: 100,
        ),
      ),
    );
  }
}
