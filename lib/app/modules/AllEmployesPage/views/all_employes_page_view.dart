import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';

import '../controllers/all_employes_page_controller.dart';

class AllEmployesPageView extends GetView<AllEmployesPageController> {
  const AllEmployesPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllEmployesPageView'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.allEmployees.length,
            itemBuilder: (context, index) {
              return _buildItem(index);
            },
          );
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    return ListTile(
      title: Text(controller.allEmployees[index].name ?? "-"),
      subtitle: Text(controller.allEmployees[index].username ?? "-"),
      trailing: Text(
        AppStorageController.to.currentUser?.userID == controller.allEmployees[index].id ? "You" : (controller.allEmployees[index].role ?? "-"),
      ),
    );
  }
}
