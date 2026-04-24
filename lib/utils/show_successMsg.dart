import 'package:flutter/material.dart';
import 'package:news_web/main.dart';

Future<void> showFailureMsg(String? msg) async {

  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(msg ?? ''),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    ),
  );
}