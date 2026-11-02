import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../features/MainHomeAppView/data/datasources/remot_data_source/user_remote_data_source.dart';

class UserPresenceService with WidgetsBindingObserver {
  final UserRemoteDataSource userRemoteDataSource;

  UserPresenceService({required this.userRemoteDataSource});

  void start() {
    WidgetsBinding.instance.addObserver(this);
    _setOnline(true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _setOnline(true);
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _setOnline(false);
        break;
    }
  }

  Future<void> _setOnline(bool online) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      if (!online) {
        await userRemoteDataSource.updateLastSeen(uid);
      }

      await userRemoteDataSource.updateOnlineStatus(uid, online);
    } catch (e) {
      debugPrint('Presence update failed: $e');
    }
  }

  Future<void> stop() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      await _setOnline(false);
    }

    dispose();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
