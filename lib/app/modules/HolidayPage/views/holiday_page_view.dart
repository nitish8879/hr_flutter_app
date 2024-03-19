import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/holiday_page_controller.dart';

class HolidayPageView extends GetView<HolidayPageController> {
  const HolidayPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HolidayPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HolidayPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
