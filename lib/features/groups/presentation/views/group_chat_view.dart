import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/groups/domain/entities/group_entities.dart';
import 'package:scholar_chat_proj/features/groups/presentation/cubit/getGroupMessagesCubit/get_group_messages_cubit.dart';
import 'package:scholar_chat_proj/features/groups/presentation/cubit/sendGroupMessageCubit/send_group_message_cubit.dart';
import 'package:scholar_chat_proj/features/groups/presentation/views/widgets/custom_app_bar_group.dart';
import 'package:scholar_chat_proj/features/groups/presentation/views/widgets/group_messages_view.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class GroupChatView extends StatefulWidget {
  const GroupChatView({super.key, required this.group});

  final GroupEntity group;

  @override
  State<GroupChatView> createState() => _GroupChatViewState();
}

class _GroupChatViewState extends State<GroupChatView> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    context.read<GetGroupMessagesCubit>().getMessages(
      groupId: widget.group.groupId,
    );
    super.initState();
  }

  void onSendMessage(String? message) {
    if (message == null || message.isEmpty) return;
    message = message.trim();
    messageController.clear();
    context.read<SendGroupMessageCubit>().sendGroupMessage(
      groupId: widget.group.groupId,
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
            CustomAppBarGroup(
              name: widget.group.name,
              membersCount: widget.group.members.length,
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
                child: GroupMessagesView(
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
