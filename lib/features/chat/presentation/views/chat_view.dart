import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/auth/domain/entities/user_entities.dart';
import 'package:scholar_chat_proj/features/chat/presentation/cubit/getMessageCubit/get_message_cubit.dart';
import 'package:scholar_chat_proj/features/chat/presentation/cubit/sendMessageCubit/send_message_cubit.dart';
import 'package:scholar_chat_proj/features/chat/presentation/views/widgets/custom_app_bar_messages.dart';
import 'package:scholar_chat_proj/features/chat/presentation/views/widgets/messages_view.dart';

import '../../../../core/generate_chat_id.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    final currentUserId = context.read<GetMessagesCubit>().currentUserId;

    if (currentUserId == null) return;

    final chatId = generateChatId(
      currentUserId,
      widget.userEntity.uid.toString(),
    );

    context.read<GetMessagesCubit>().getMessages(chatId: chatId);
    super.initState();
  }

  void onSendMessage(String? message) {
    if (message == null || message.isEmpty) return;
    message = message.trim();
    messageController.clear();
    context.read<SendMessageCubit>().sendMessage(
      receiveId: widget.userEntity.uid.toString(),
      message: message,
    );
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
            CustomAppBarMessages(
              name: widget.userEntity.username,
              isOnline: widget.userEntity.isOnline,
            ),
            const SizedBox(height: Sizes.s16),
            Expanded(
              child: Container(
                width: double.infinity,
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
                child: MessagesView(
                  focusNode: focusNode,
                  messageController: messageController,
                  scrollController: scrollController,
                  onSendMessage: (value) {
                    onSendMessage(value);
                  },
                ),
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
