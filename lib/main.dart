import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_proj/core/resources/app_texts.dart';
import 'package:scholar_chat_proj/core/routes/route_generator.dart';
import 'package:scholar_chat_proj/core/routes/routes.dart';

import 'core/resources/app_them.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTexts.appName,
      theme: AppThem.darkThem(),
      initialRoute: Routes.chatView,
      routes: RouteGenerator.routes,
    );
  }
}
