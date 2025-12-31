import 'package:flutter/material.dart';

class HomeViewModel {
  void startVoiceTest(BuildContext context) {
    Navigator.pushNamed(context, '/voice');
  }
}