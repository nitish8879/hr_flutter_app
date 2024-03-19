import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';

import '../controllers/leave_page_controller.dart';

class LeavePageView extends GetView<LeavePageController> {
  const LeavePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeavePageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LeavePageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
