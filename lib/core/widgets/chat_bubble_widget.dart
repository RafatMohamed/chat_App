import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';
import 'package:scholar_chat_proj/features/chat/domain/entities/message_entities.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../resources/color_manager.dart';

class CustomMessageBubble extends StatelessWidget {
  const CustomMessageBubble({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    final isMe = message.senderId == FirebaseAuth.instance.currentUser?.uid;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.72,
              ),
              padding: const EdgeInsets.fromLTRB(15, 13, 15, 10),
              decoration: BoxDecoration(
                color: isMe ? AppColors.sentMessage : AppColors.receivedMessage,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(message.text, style: AppTextStyles.message),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isMe) ...[
                        Text(
                          timeago.format(message.createdAt, locale: 'en_short'),
                          style: AppTextStyles.messageTime.copyWith(
                            color: const Color(0xFFD0D2EB),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          // message.isPending
                          //     ? Icons.access_time
                          //     : message.isRead
                          //     ? Icons.done_all
                          //     : Icons.done,
                          Icons.done_all,
                          size: 13,
                          color:
                              // message.isRead
                              //     ? AppColors.online
                              //     : AppColors.pending,
                              AppColors.online,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isMe) ...[
            const SizedBox(height: 6),
            Text(
              timeago.format(message.createdAt, locale: 'en_short'),
              style: AppTextStyles.messageTime,
            ),
          ],
        ],
      ),
    );
  }
}
