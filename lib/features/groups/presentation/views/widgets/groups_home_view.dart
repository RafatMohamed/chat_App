import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/groups/domain/entities/group_entities.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/routes/routes.dart';
import 'custom_group_home_item.dart';

class GroupsHomeView extends StatelessWidget {
  const GroupsHomeView({super.key, required this.groups});

  final List<GroupEntity> groups;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Insets.s14),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.groupChatView,
                arguments: group,
              );
            },
            child: CustomGroupHomeItem(group: group),
          ),
        );
      },
    );
  }
}
