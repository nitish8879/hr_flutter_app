import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_activity_model.dart';
import 'package:hr_application/app/modules/LeavePage/views/apply_leave_page_view.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';
import 'package:hr_application/widgets/leave_activity_card.dart';

import '../controllers/leave_page_controller.dart';

class LeavePageView extends GetView<LeavePageController> {
  const LeavePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        title: const Text("All Leaves"),
        actions: [
          IconButton.outlined(
            onPressed: controller.getAllLeaves,
            icon: const Icon(Icons.refresh),
          ),
          14.width,
          //? ADD Button
          if ((AppStorageController.to.currentUser?.roleType ==
                  UserRoleType.admin ||
              AppStorageController.to.currentUser?.roleType ==
                  UserRoleType.manager)) ...[
            Row(
              children: [
                IconButton.outlined(
                  onPressed: () => Get.to(() => const ApplyLeavePageView()),
                  icon: const Icon(Icons.add),
                ),
                14.width,
              ],
            ),
          ],

          if (AppStorageController.to.currentUser?.roleType ==
                  UserRoleType.admin ||
              AppStorageController.to.currentUser?.roleType ==
                  UserRoleType.manager) ...[
            Obx(
              () {
                return Row(
                  children: [
                    Text(controller.myData.value ? "My" : "Other"),
                    4.width,
                    Switch(
                      value: controller.myData.value,
                      onChanged: controller.myDataChanged,
                    ),
                  ],
                );
              },
            ),
            14.width,
          ],
        ],
      ),
      body: Column(
        children: [
          Obx(
            () {
              return (controller.totalCount.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildOverViewLeave(
                              "Balance",
                              controller.totalCount['totalLeavebalance'] ?? 0,
                              AppColors.kBlue900,
                            ),
                          ),
                          16.width,
                          Expanded(
                            child: _buildOverViewLeave(
                              "Balance",
                              controller.totalCount['totalLeavebalance'] ?? 0,
                              AppColors.kOrange500,
                              prefixLabel: "WFH",
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
            },
          ),
          14.height,
          _buildTabs(),
          Expanded(
            child: _buildLeavList(),
          ),
        ],
      ),
    );
  }

  _buildOverViewLeave(String label, int count, Color color,
      {String? prefixLabel}) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prefixLabel ?? "Leave",
            style: Get.textTheme.bodyLarge,
          ),
          Text(
            label,
            style: Get.textTheme.bodyLarge,
          ),
          5.height,
          Text(
            count.toString(),
            style: Get.textTheme.headlineSmall?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  _buildLeaveUI(String label, count) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.kFoundationPurple700,
            borderRadius: borderRadius,
            border: Border.all(
              color: AppColors.kBorderColor,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (count ?? '-').toString(),
                style: Get.textTheme.headlineMedium?.copyWith(
                  color: AppColors.kWhite,
                ),
              ),
              Text(
                label,
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: AppColors.kWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeavList() {
    return Obx(() {
      return (controller.leaveActivities.isEmpty)
          ? const Center(
              child: Text("No Data found."),
            )
          : ListView.builder(
              itemCount: controller.leaveActivities.length,
              itemBuilder: (context, index) {
                return LeaveActivityCard(
                  item: controller.leaveActivities[index],
                );
              },
            );
    });
  }

  _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        controller.leaveActivities.value;
        return Row(
          children: LeaveActivityState.list.map(
            (e) {
              bool isSelected = controller.tabSelected.value ==
                  LeaveActivityState.fromStrings(e);

              final count = controller.mainList
                  .where((element) =>
                      element.leaveStatus == LeaveActivityState.fromStrings(e))
                  .length;
              return Expanded(
                child: InkWell(
                  onTap: () => controller
                      .onTabChange(LeaveActivityState.fromStrings(e)!),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.kFoundationPurple700
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "$e ${count == 0 ? '' : count}",
                        style: Get.textTheme.bodyLarge?.copyWith(
                          color:
                              isSelected ? AppColors.kWhite : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        );
      }),
    );
  }
}
