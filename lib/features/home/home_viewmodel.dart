import 'package:flutter/material.dart';

class HomeViewModel {
  String userName = "Arthur";
  int streakDays = 3;
  int streakPercent = 75;

  void startVoiceTest(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed('/voice');
  }

  void openDetails() {}
}
