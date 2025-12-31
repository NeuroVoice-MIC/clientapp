import 'package:flutter/material.dart';

class OnboardingViewModel {
  void start(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }
}