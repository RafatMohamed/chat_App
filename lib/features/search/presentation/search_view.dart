import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/features/search/presentation/widgets/custom_app_bar_search.dart';
import 'package:scholar_chat_proj/features/search/presentation/widgets/search_empty_view.dart';
import 'package:scholar_chat_proj/features/search/presentation/widgets/search_view_body.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/values_manager.dart';
import '../../home/presentation/home_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Insets.s18,
            horizontal: Insets.s16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBarSearch(),
              const SizedBox(height: Sizes.s28),
              Text(
                "(${users.length} ${AppTexts.peopleFound})",
                style: AppTextStyles.hint,
              ),
              Expanded(
                child:
                    users.isNotEmpty
                        ? SearchViewBody(users: users)
                        : const SearchEmptyView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
