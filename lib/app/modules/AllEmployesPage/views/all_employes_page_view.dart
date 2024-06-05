import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_application/app/models/teams_model.dart';
import 'package:hr_application/data/app_enums.dart';
import 'package:hr_application/data/controllers/app_storage_service.dart';
import 'package:hr_application/data/models/user_data_model.dart';
import 'package:hr_application/utils/app_extension.dart';
import 'package:hr_application/utils/theme/app_colors.dart';
import 'package:hr_application/widgets/app_textfield.dart';

import '../controllers/all_employes_page_controller.dart';

class AllEmployesPageView extends GetView<AllEmployesPageController> {
  const AllEmployesPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.height,
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      "Teams",
                      style: Get.textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: controller.fetchAllTeams,
                        icon: const Icon(Icons.refresh)),
                    FutureBuilder<UserDataModel?>(
                      future: AppStorageController.to.asyncCurrentUser,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            (snapshot.data?.roleType == UserRoleType.watcher) ||
                            (snapshot.data?.roleType ==
                                UserRoleType.employee) ||
                            (snapshot.data?.roleType == UserRoleType.manager)) {
                          return const SizedBox();
                        }
                        return IconButton(
                          onPressed: addTeamDialog,
                          icon: const Icon(Icons.people),
                        );
                      },
                    )
                  ],
                ),
              ),
              4.height,
              Obx(
                () {
                  if (controller.isTeamLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.teams.isEmpty) {
                    return const Center(
                      child: Text("No Teams Found"),
                    );
                  }
                  return Column(
                    children: List.generate(controller.teams.length,
                        (index) => _buildTeamItem(index)).toList(),
                  );
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Members",
                      style: Get.textTheme.headlineSmall,
                    ),
                    Obx(() {
                      controller.isTeamLoading.value;
                      return FutureBuilder<UserDataModel?>(
                        future: AppStorageController.to.asyncCurrentUser,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              (snapshot.data?.roleType ==
                                  UserRoleType.watcher) ||
                              (snapshot.data?.roleType ==
                                  UserRoleType.employee) ||
                              (snapshot.data?.roleType ==
                                  UserRoleType.manager) ||
                              controller.teams.isEmpty) {
                            return const SizedBox();
                          }
                          return IconButton(
                            onPressed: addMembersDialog,
                            icon: const Icon(Icons.person),
                          );
                        },
                      );
                    })
                  ],
                ),
              ),
              Obx(
                () {
                  if (controller.isMemberLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.members?.members?.isEmpty ?? true) {
                    return const Center(
                      child: Text("No Members Found"),
                    );
                  }
                  return Column(
                    children: List.generate(
                        controller.members?.members?.length ?? 0,
                        (index) => _buildMembersItem(index)).toList(),
                  );
                },
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }

  void addTeamDialog() {
    String teamname = "";
    Get.defaultDialog(
      title: "Add Team",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            hintText: "Team Name",
            onChanged: (p) => teamname = p,
          )
        ],
      ),
      textCancel: "Cancel",
      onConfirm: () => controller.addTeam(teamname),
      textConfirm: "Add Team",
    );
  }

  void addMembersDialog() {
    String fullName = "", username = "";
    UserRoleType selectedRole = UserRoleType.watcher;
    TeamsModel selectedTeam = controller.teams.first;

    List<String> list = List.from(UserRoleType.list);
    if (AppStorageController.to.currentUser?.roleType ==
        UserRoleType.superAdmin) {
      list.removeWhere((element) => element == UserRoleType.superAdmin.code);
    }
    if (AppStorageController.to.currentUser?.roleType == UserRoleType.admin) {
      list.removeWhere((element) => element == UserRoleType.superAdmin.code);
      list.removeWhere((element) => element == UserRoleType.admin.code);
    }
    Get.defaultDialog(
      title: "Add Member",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            hintText: "Full Name",
            onChanged: (p) => fullName = p,
          ),
          8.height,
          AppTextField(
            hintText: "Email",
            onChanged: (p) => username = p,
          ),
          8.height,
          //? TEAMS
          StatefulBuilder(builder: (context, s) {
            return DropdownButton<TeamsModel>(
              items: controller.teams
                  .map(
                    (e) => DropdownMenuItem<TeamsModel>(
                      value: e,
                      child: Text(e.teamName ?? "?"),
                    ),
                  )
                  .toList(),
              value: selectedTeam,
              onChanged: (a) {
                selectedTeam = a!;
                s(() {});
              },
            );
          }),
          8.height,
          //? ROLE
          StatefulBuilder(builder: (context, s) {
            return DropdownButton(
              items: list
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              value: selectedRole.code,
              onChanged: (a) {
                selectedRole = UserRoleType.fromString(a!);
                s(() {});
              },
            );
          })
        ],
      ),
      textCancel: "Cancel",
      onConfirm: () => controller.addMembers(fullName, username, selectedRole),
      textConfirm: "Add Member",
    );
  }

  Widget _buildTeamItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: InkWell(
        onTap: () => controller.onTeamTap(controller.teams[index]),
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColors.kGrey100,
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
            border: Border.all(
              width: controller.teams[index].id == controller.selectedTeam?.id
                  ? 1
                  : 0,
              color: controller.teams[index].id == controller.selectedTeam?.id
                  ? AppColors.kPurple900
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Expanded(child: Text(controller.teams[index].teamName ?? "-")),
              if (controller.teams[index].id ==
                  controller.selectedTeam?.id) ...[
                16.width,
                const Icon(Icons.check),
                16.width,
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMembersItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Ink(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.kGrey100,
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: double.maxFinite),
            Text(controller.members?.members?[index].fullName ?? "-"),
            Text(controller.members?.members?[index].userName ?? "-"),
            Text(controller.members?.members?[index].roleType ?? "-"),
            // if (controller.members?.members?[index].id ==
            //     controller.members?.manager?.id) ...[
            //   6.height,
            //   6.height,
            // ]
          ],
        ),
      ),
    );
  }
}
