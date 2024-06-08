import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hr_application/app/modules/LeavePage/model/leave_activity_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/utils/theme/app_theme.dart';

class LeaveActivityCard extends StatelessWidget {
  final LeaveActivityModel item;
  final void Function(LeaveActivityState state)? approveRejectTap;
  const LeaveActivityCard({
    super.key,
    required this.item,
    this.approveRejectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: kBoxShadow,
        borderRadius: borderRadius,
        color: AppColors.kWhite,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: Get.textTheme.bodyLarge,
                  ),
                  5.height,
                  Text(
                    "${item.fromdate?.toMMDDYYYY ?? '.'} - ${item.todate?.toMMDDYYYY ?? '.'}",
                    style: Get.textTheme.headlineSmall?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: item.leaveStatus?.getColor.withOpacity(.1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  item.leaveStatus?.getName ?? "-",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: item.leaveStatus?.getColor,
                  ),
                ),
              )
            ],
          ),
          8.height,
          const Divider(
            color: AppColors.kGrey100,
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buidlTitleAndSubTitle(
                "Apply Days",
                '${(item.todate?.add(Duration(days: 1)))?.difference(item.fromdate!).inDays.toString() ?? "0"} Days',
              ),
              _buidlTitleAndSubTitle("Approval", item.approvalTo?.fullName ?? "-"),
            ],
          ),
          if (((AppStorageController.to.currentUser?.roleType == UserRoleType.superAdmin ||
                      AppStorageController.to.currentUser?.roleType == UserRoleType.admin ||
                      AppStorageController.to.currentUser?.roleType == UserRoleType.manager) &&
                  AppStorageController.to.currentUser?.userID == item.approvalTo?.id) &&
              item.leaveStatus == LeaveActivityState.pending) ...[
            8.height,
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => approveRejectTap != null ? approveRejectTap!(LeaveActivityState.approved) : null,
                    child: const Text("Approve"),
                  ),
                ),
                24.width,
                Expanded(
                  child: FilledButton(
                    onPressed: () => approveRejectTap != null ? approveRejectTap!(LeaveActivityState.rejected) : null,
                    child: const Text("Reject"),
                  ),
                ),
              ],
            ),
          ],
          if (item.leaveStatus == LeaveActivityState.rejected) ...[
            const Divider(
              color: AppColors.kGrey100,
            ),
            _buidlTitleAndSubTitle(
              "Rejected Reason",
              item.rejectedReason ?? "-",
            ),
          ]
        ],
      ),
    );
  }

  _buidlTitleAndSubTitle(String label, String approveBy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Get.textTheme.bodyLarge,
        ),
        5.height,
        Text(
          approveBy,
          style: Get.textTheme.headlineSmall?.copyWith(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
