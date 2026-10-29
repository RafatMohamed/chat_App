import 'package:flutter/material.dart';

import '../../../../core/widgets/chat_bubble_widget.dart';

class CustomMessagesItem extends StatelessWidget {
  const CustomMessagesItem({super.key, required this.message});

  final ChatMessageModel message;

  @override
  Widget build(BuildContext context) {
    return CustomMessageBubble(
      message: ChatMessageModel(
        text: message.text,
        isMe: message.isMe,
        time: message.time,
        isRead: message.isRead,
        isPending: message.isPending,
      ),
    );
  }
}
