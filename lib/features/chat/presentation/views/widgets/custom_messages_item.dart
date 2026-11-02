import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/message_entities.dart';

import '../../../../../core/widgets/chat_bubble_widget.dart';

class CustomMessagesItem extends StatelessWidget {
  const CustomMessagesItem({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return CustomMessageBubble(message: message);
  }
}
