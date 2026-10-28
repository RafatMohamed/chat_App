import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/values_manager.dart';
import 'package:scholar_chat_proj/features/home/presentation/home_view.dart';

import '../../profile/presentation/profile_view.dart';
import '../../search/presentation/search_view.dart';
import '../widgets/default_bottom_nav_bar.dart';

class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 0;
  late final List<Widget> _screens = [
    const HomeView(),
    const SearchView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _screens),
          Positioned(
            bottom: Insets.s16,
            left: Insets.s10,
            right: Insets.s10,
            child: DefaultBottomNavigationBar(
              currentIndex: _currentIndex,
              onCurrentIndexChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
