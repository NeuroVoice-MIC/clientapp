import 'package:flutter/material.dart';
import 'voice_check_viewmodel.dart';

class VoiceCheckView extends StatelessWidget {
  const VoiceCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = VoiceCheckViewModel();

    return Scaffold(
      appBar: AppBar(title: const Text("Voice Check")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Say \"aaaa\" for 10 seconds",
              style: TextStyle(fontSize: 18)),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => vm.record(context),
            child: const Text("Start Recording"),
          )
        ],
      ),
    );
  }
}