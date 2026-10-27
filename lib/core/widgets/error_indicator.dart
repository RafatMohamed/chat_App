import 'package:flutter/material.dart';

import '../resources/app_texts.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;

  const ErrorIndicator({this.message = AppTexts.somethingWentWrong, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
