import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/chat_item_entity.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes/routes.dart';
import 'custom_chat_home_item.dart';

class ChatsHomeView extends StatelessWidget {
  const ChatsHomeView({super.key, required this.chats});

  final List<ChatItemEntity> chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      // padding: const EdgeInsets.symmetric(vertical: Insets.s12),
      itemBuilder: (context, index) {
        final item = chats[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Insets.s14),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.chatView,
                arguments: item.otherUser,
              );
            },
            child: CustomChatHomeItem(chats: item),
          ),
        );
      },
    );
  }
}
