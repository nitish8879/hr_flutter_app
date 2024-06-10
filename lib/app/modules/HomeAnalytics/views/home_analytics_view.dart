import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';

import '../controllers/home_analytics_controller.dart';

class HomeAnalyticsView extends GetView<HomeAnalyticsController> {
  @override
  Widget build(BuildContext context) {
    controller.fetchHomeAnalyticsData();
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppStorageController.to.currentUser?.companyName} Info'),
        centerTitle: true,
      ),
      body: ListView(
        children: [Text("data")],
      ),
    );
  }
}
