import 'package:flutter/material.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = HomeViewModel();

    return Scaffold(
      appBar: AppBar(title: const Text("NeuroVoice")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good morning 👋", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.mic),
              label: const Text("Start Voice Test"),
              onPressed: () => vm.startVoiceTest(context),
            ),
          ],
        ),
      ),
    );
  }
}