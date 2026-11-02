import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/core/resources/app_text_styles.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/resources/color_manager.dart';
import 'package:scholar_chat_proj/core/widgets/custom_text_field.dart';
import 'package:scholar_chat_proj/core/widgets/loading_indicator.dart';
import 'package:scholar_chat_proj/features/chat/presentation/cubit/getMessageCubit/get_message_cubit.dart';
import 'package:scholar_chat_proj/features/chat/presentation/views/widgets/message_empty_view.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../cubit/getMessageCubit/get_message_state.dart';
import 'custom_messages_item.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({
    super.key,
    required this.scrollController,
    required this.messageController,
    required this.onSendMessage,
    required this.focusNode,
  });

  final ScrollController scrollController;
  final TextEditingController messageController;
  final ValueChanged<String?> onSendMessage;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<GetMessagesCubit, GetMessagesState>(
            builder: (context, state) {
              if (state is MessagesLoading) {
                return const LoadingIndicator();
              }
              if (state is MessagesFailure) {
                return Center(
                  child: Text(
                    state.message,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }
              if (state is MessagesLoaded) {
                return state.messages.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.messages.length,
                        controller: scrollController,
                        padding: const EdgeInsets.only(
                          left: Insets.s16,
                          right: Insets.s16,
                          bottom: Insets.s32,
                        ),
                        itemBuilder: (context, index) {
                          final messageResult = state.messages[index];
                          return CustomMessagesItem(message: messageResult);
                        },
                      )
                    : const MessagesEmptyView();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadiusGeometry.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          padding: const EdgeInsets.all(Insets.s16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextField(
                  hint: AppTexts.typeMessage,
                  controller: messageController,
                  textInputType: TextInputType.multiline,
                  maxLines: 2,
                  focusNode: focusNode,
                  isNewLine: true,
                  onFieldSubmitted: onSendMessage,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file,
                      color: AppColors.accent,
                      size: 21,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: AppColors.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    onSendMessage(messageController.text.trim());
                  },
                  child: const SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }
}
