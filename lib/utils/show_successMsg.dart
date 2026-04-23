
import 'package:flutter/material.dart';
import 'package:news_web/main.dart';

//set func. for FailureMsg
Future<void> showFailureMsg(String? Msg) async {

  ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!).showSnackBar(SnackBar(content:Text(Msg!),
    duration: await Future.delayed(Duration(seconds: 3)),
    backgroundColor: Colors.red,
  ),
  );
}