import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/home/presentation/home_view.dart';

import '../../../../core/resources/values_manager.dart';
import 'custom_chat_item.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key, required this.users});

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      // padding: const EdgeInsets.symmetric(vertical: Insets.s12),
      itemBuilder: (context, index) {
        final item = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Insets.s14),
          child: CustomChatItem(item: item),
        );
      },
    );
  }
}
