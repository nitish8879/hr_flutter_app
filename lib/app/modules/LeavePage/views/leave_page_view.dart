import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_activity_model.dart';
import 'package:hr_application/app/modules/LeavePage/views/apply_leave_page_view.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/widgets/leave_activity_card.dart';

import '../controllers/leave_page_controller.dart';

class LeavePageView extends GetView<LeavePageController> {
  const LeavePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return RefreshIndicator(
            onRefresh: controller.onRefresh,
            child: CustomScrollView(
              slivers: [
                _buildAppBar(),
                _buildLeavList(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLeavList() {
    if (controller.leaveActivities.isEmpty) {
      return const SliverToBoxAdapter(
        child: Text("No Data found."),
      );
    } else {
      return SliverList.builder(
        itemCount: controller.leaveActivities.length,
        itemBuilder: (context, index) {
          return LeaveActivityCard(
            item: controller.leaveActivities[index],
          );
        },
      );
    }
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      backgroundColor: AppColors.kGrey50,
      surfaceTintColor: AppColors.kGrey50,
      title: Text(
        "All Leaves",
        style: Get.textTheme.headlineSmall,
      ),
      pinned: true,
      actions: [
        IconButton.outlined(
          onPressed: () => Get.to(() => const ApplyLeavePageView()),
          icon: const Icon(Icons.add),
        ),
        14.width,
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            return Column(
              children: [
                (kToolbarHeight + 14).height,
                Row(
                  children: [
                    Expanded(
                      child: _buildOverViewLeave(
                        "Balance",
                        controller.leavTotalCount.value?.totalLeaveBalance ?? 0,
                        AppColors.kBlue900,
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: _buildOverViewLeave(
                        "Approved",
                        controller.leavTotalCount.value?.totalLeaveApproved ?? 0,
                        AppColors.kGreen700,
                      ),
                    ),
                  ],
                ),
                16.height,
                Row(
                  children: [
                    Expanded(
                      child: _buildOverViewLeave(
                        "Pending",
                        controller.leavTotalCount.value?.totalLeavePending ?? 0,
                        AppColors.kFoundationPurple700,
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: _buildOverViewLeave(
                        "Cancelled",
                        controller.leavTotalCount.value?.totalLeaveCancelled ?? 0,
                        AppColors.kFailureRed,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
      bottom: AppBar(
        toolbarHeight: 70,
        surfaceTintColor: AppColors.kGrey50,
        backgroundColor: AppColors.kGrey50,
        flexibleSpace: _buildTabs(),
      ),
    );
  }

  _buildOverViewLeave(String label, int count, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        // border: Border.all(
        //   color: color,
        //   width: 1.5,
        // ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Leave",
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

  _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        return Row(
          children: LeaveActivityState.list.map(
            (e) {
              bool isSelected = controller.tabSelected.value == LeaveActivityState.fromStrings(e);
              return Expanded(
                child: InkWell(
                  onTap: () => controller.onTabChange(LeaveActivityState.fromStrings(e)!),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    height: 55,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.blueColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        e,
                        style: Get.textTheme.bodyLarge?.copyWith(
                          color: isSelected ? AppColors.kWhite : AppColors.black,
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
