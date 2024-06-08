import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_analytics_controller.dart';

class HomeAnalyticsView extends GetView<HomeAnalyticsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeAnalyticsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeAnalyticsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
