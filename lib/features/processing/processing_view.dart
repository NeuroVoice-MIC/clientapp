import 'package:flutter/material.dart';
import 'processing_viewmodel.dart';

class ProcessingView extends StatelessWidget {
  const ProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = ProcessingViewModel();

    vm.process(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Analyzing voice stability...")
          ],
        ),
      ),
    );
  }
}