import 'package:flutter/material.dart';

class ProcessingViewModel {
  Future<void> process(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushNamed(context, '/results');
  }
}