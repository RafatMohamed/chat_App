import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/get_user_name_first_char.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/chat_empty_view.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/chat_view.dart';
import 'package:scholar_chat_proj/features/home/presentation/widgets/cutom_app_bar_home.dart';

import '../../../core/resources/app_text_styles.dart';
import '../../../core/resources/app_texts.dart';
import '../../../core/resources/values_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
            children: [
              const CustomAppBarHome(),
              const SizedBox(height: Sizes.s20),
              Row(
                spacing: 8,
                children: [
                  const Text(
                    AppTexts.recentChat,
                    style: AppTextStyles.titleMedium,
                  ),
                  Text("(${users.length})", style: AppTextStyles.hint),
                ],
              ),
              Expanded(
                child:
                    users.isNotEmpty
                        ? ChatsView(users: users)
                        : const ChatEmptyView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String bio;
  final bool? isOnline;
  final String charName;

  UserModel({
    required this.id,
    required this.name,
    required this.bio,
    this.isOnline,
  }) : charName = getUserChar(name);
}

List<UserModel> users = [
  UserModel(
    id: "1",
    name: "Raafat Mohamed",
    bio: "Flutter Dev",
    isOnline: true,
  ),
  UserModel(id: "2", name: "Khalid Ahmed", bio: "Backend Dev", isOnline: false),
  UserModel(id: "3", name: "Ahmed Mohamed", bio: "Sales", isOnline: true),
  UserModel(
    id: "1",
    name: "Raafat Mohamed",
    bio: "Flutter Dev",
    isOnline: true,
  ),
  UserModel(id: "2", name: "Khalid Ahmed", bio: "Backend Dev", isOnline: false),
  UserModel(id: "3", name: "Ahmed Mohamed", bio: "Sales", isOnline: true),
  UserModel(
    id: "1",
    name: "Raafat Mohamed",
    bio: "Flutter Dev",
    isOnline: true,
  ),
  UserModel(id: "2", name: "Khalid Ahmed", bio: "Backend Dev", isOnline: false),
  UserModel(id: "3", name: "Ahmed Mohamed", bio: "Sales", isOnline: true),
  UserModel(
    id: "1",
    name: "Raafat Mohamed",
    bio: "Flutter Dev",
    isOnline: true,
  ),
  UserModel(id: "2", name: "Khalid Ahmed", bio: "Backend Dev", isOnline: false),
  UserModel(id: "3", name: "Ahmed Mohamed", bio: "Sales", isOnline: true),
  UserModel(
    id: "1",
    name: "Raafat Mohamed",
    bio: "Flutter Dev",
    isOnline: true,
  ),
  UserModel(id: "2", name: "Khalid Ahmed", bio: "Backend Dev", isOnline: false),
  UserModel(id: "3", name: "Ahmed Mohamed", bio: "Sales", isOnline: true),
  UserModel(
    id: "1",
    name: "Raafat Mohamed",
    bio: "Flutter Dev",
    isOnline: true,
  ),
  UserModel(id: "2", name: "Khalid Ahmed", bio: "Backend Dev", isOnline: false),
  UserModel(id: "3", name: "Ahmed Mohamed", bio: "Sales", isOnline: true),
];
