import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/widgets/chat_bubble_widget.dart';
import 'package:scholar_chat_proj/features/chat/views/widgets/custom_app_bar_messages.dart';
import 'package:scholar_chat_proj/features/chat/views/widgets/message_empty_view.dart';
import 'package:scholar_chat_proj/features/chat/views/widgets/messages_view.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../home/presentation/home_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<ChatMessageModel> _messages = [
    ChatMessageModel(
      text: 'Hey Raafat! Did you check the new project requirements?',
      time: Timestamp.fromDate(DateTime(2020)),
      isMe: false,
    ),
    ChatMessageModel(
      text:
          'Yes! Just reviewed them. Clean architecture with Flutter and Firebase looks great.',
      time: Timestamp.fromDate(DateTime(2020)),
      isMe: true,
      isRead: true,
    ),
    ChatMessageModel(
      text: 'Awesome. Are we meeting later to discuss the UI implementation?',
      time: Timestamp.fromDate(DateTime(2020)),
      isMe: false,
    ),
    ChatMessageModel(
      text: 'Sounds good! Let me know what time works best.',
      time: Timestamp.fromDate(DateTime(2020)),
      isMe: true,
      isPending: true,
    ),
  ];
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void onSendMessage(String? message) {
    if (message == null || message.isEmpty) return;
    message = message.trim();
    messageController.clear();

    setState(() {
      _messages.add(
        ChatMessageModel(
          text: message!,
          time: Timestamp.fromDate(DateTime.now()),
          isMe: false,
          isPending: true,
        ),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: Insets.s16),
            const CustomAppBarMessages(name: "Raafat Mohamed"),
            const SizedBox(height: Sizes.s16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  border: Border.all(color: Colors.transparent),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.inputBackground,
                      AppColors.primary.withValues(alpha: 0.5),
                      AppColors.surface,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child:
                    users.isNotEmpty
                        ? MessagesView(
                          focusNode: focusNode,
                          messages: _messages,
                          messageController: messageController,
                          scrollController: scrollController,
                          onSendMessage: onSendMessage,
                        )
                        : const MessagesEmptyView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    scrollController.dispose();
    messageController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
