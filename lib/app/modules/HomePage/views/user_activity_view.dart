import 'package:flutter/material.dart';
import 'package:hr_application/app/modules/HomePage/model/user_activity_model.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/widgets/activity_card.dart';
import 'package:intl/intl.dart';

class UserActivityView extends StatelessWidget {
  final UserActivityModel? userActivityModel;
  const UserActivityView({required this.userActivityModel, super.key});

  @override
  Widget build(BuildContext context) {
    if (userActivityModel == null) {
      return const SizedBox();
    }
    return Column(
      children: [
        if (userActivityModel!.checkIn != null) ...{
          ActivityCard(
            iconData: Icons.input_rounded,
            title: "Check In",
            dateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse("${userActivityModel!.checkIn!.date!} ${userActivityModel!.checkIn!.inTime!}"),
            description: userActivityModel!.checkIn?.msg ?? '-',
          )
        },
        if (userActivityModel!.breakInTime != null) ...{
          16.height,
          ActivityCard(
            iconData: Icons.free_breakfast_outlined,
            title: "Break In ",
            dateTime:
                DateFormat("yyyy-MM-dd hh:mm:ss").parse("${userActivityModel!.breakInTime!.date!} ${userActivityModel!.breakInTime!.breakInTime!}"),
            description: "",
          ),
        },
        if (userActivityModel!.breakOutTime != null) ...{
          16.height,
          ActivityCard(
            iconData: Icons.free_breakfast_outlined,
            title: "Break Out ",
            dateTime: DateFormat("yyyy-MM-dd hh:mm:ss")
                .parse("${userActivityModel!.breakOutTime!.date!} ${userActivityModel!.breakOutTime!.breakOutTime!}"),
            description: "",
          )
        },
        if (userActivityModel!.outTime != null) ...{
          16.height,
          ActivityCard(
            iconData: Icons.input,
            title: "Check Out",
            dateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse("${userActivityModel!.outTime!.date!} ${userActivityModel!.outTime!.outTime!}"),
            description: userActivityModel!.outTime?.msg ?? '-',
          )
        },
      ],
    );
  }
}
