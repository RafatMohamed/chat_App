import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_proj/features/search/presentation/cubit/search_cubit.dart';
import 'package:scholar_chat_proj/features/search/presentation/widgets/custom_app_bar_search.dart';
import 'package:scholar_chat_proj/features/search/presentation/widgets/search_empty_view.dart';
import 'package:scholar_chat_proj/features/search/presentation/widgets/search_view_body.dart';

import '../../../../core/resources/app_text_styles.dart';
import '../../../../core/resources/app_texts.dart';
import '../../../../core/resources/values_manager.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    void onChange(String? query) async {
      if (query == null) return;
      cubit.getUsersFiltered(query: query);
    }

    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.s18,
                horizontal: Insets.s16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBarSearch(
                    onChange: (value) {
                      onChange(value);
                    },
                  ),
                  const SizedBox(height: Sizes.s28),
                  Text(
                    "(${cubit.users.length} ${AppTexts.peopleFound})",
                    style: AppTextStyles.hint,
                  ),
                  Expanded(
                    child: cubit.users.isNotEmpty
                        ? SearchViewBody(users: cubit.users)
                        : const SearchEmptyView(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
