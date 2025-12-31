import 'package:flutter/material.dart';

class VoiceCheckViewModel {
  void record(BuildContext context) async {
    // Audio recording will go here
    Navigator.pushNamed(context, '/processing');
  }
}