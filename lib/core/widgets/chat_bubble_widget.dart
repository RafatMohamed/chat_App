import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../resources/color_manager.dart';

class CustomMessageBubble extends StatelessWidget {
  const CustomMessageBubble({super.key, required this.message});

  final ChatMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Align(
            alignment:
                message.isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.72,
              ),
              padding: const EdgeInsets.fromLTRB(15, 13, 15, 10),
              decoration: BoxDecoration(
                color:
                    message.isMe
                        ? AppColors.sentMessage
                        : AppColors.receivedMessage,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(message.isMe ? 16 : 4),
                  bottomRight: Radius.circular(message.isMe ? 4 : 16),
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
                      if (message.isMe) ...[
                        Text(
                          message.time != null
                              ? timeago.format(
                                message.time.toDate(),
                                locale: 'en_short',
                              )
                              : AppTexts.justNow,
                          style: AppTextStyles.messageTime.copyWith(
                            color: const Color(0xFFD0D2EB),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          message.isPending
                              ? Icons.access_time
                              : message.isRead
                              ? Icons.done_all
                              : Icons.done,
                          size: 13,
                          color:
                              message.isRead
                                  ? AppColors.online
                                  : AppColors.pending,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!message.isMe) ...[
            const SizedBox(height: 6),
            Text(
              message.time != null
                  ? timeago.format(message.time.toDate(), locale: 'en_short')
                  : AppTexts.justNow,
              style: AppTextStyles.messageTime,
            ),
          ],
        ],
      ),
    );
  }
}

class ChatMessageModel {
  const ChatMessageModel({
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
    this.isPending = false,
  });

  final String text;
  final Timestamp time;
  final bool isMe;
  final bool isRead;
  final bool isPending;
}
