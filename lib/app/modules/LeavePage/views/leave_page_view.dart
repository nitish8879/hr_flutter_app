import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_activity_model.dart';
import 'package:hr_application/app/routes/app_pages.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/widgets/leave_activity_card.dart';

import '../controllers/leave_page_controller.dart';

class LeavePageView extends GetView<LeavePageController> {
  const LeavePageView({super.key});
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
          if (AppStorageController.to.currentUser?.roleType !=
              UserRoleType.superAdmin) ...[
            Row(
              children: [
                IconButton.outlined(
                  onPressed: () => Get.toNamed(Routes.APPLY_LEAVE_PAGE),
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
                              "Leave",
                              controller.totalCount['paidLeaveBalance'],
                              AppColors.kBlue900,
                              prefixLabel: "Paid",
                            ),
                          ),
                          16.width,
                          Expanded(
                            child: _buildOverViewLeave(
                              "Leave",
                              controller
                                  .totalCount['casualAndSickLeaveBalance'],
                              AppColors.kBlue900,
                              prefixLabel: "Casual/Sick",
                            ),
                          ),
                          16.width,
                          Expanded(
                            child: _buildOverViewLeave(
                              "Balance",
                              controller.totalCount['totalWFHbalance'],
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

  _buildOverViewLeave(String label, int? count, Color color,
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
            (count ?? '-').toString(),
            style: Get.textTheme.headlineSmall?.copyWith(
              color: color,
            ),
          ),
        ],
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
                  approveRejectTap: (status) =>
                      controller.handleApproveRejectTap(
                    status,
                    controller.leaveActivities[index],
                  ),
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
