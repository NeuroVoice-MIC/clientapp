import 'package:clientapp/features/voice_check/voice_check_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProcessingView extends StatelessWidget {
  const ProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VoiceCheckViewModel>();

    // 🔥 THIS must live here
    if (vm.shouldNavigateToResults) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
          context,
          '/results',
          arguments: {
            'detected': vm.parkinsonsDetected,
            'confidence': vm.confidence,
          },
        );
        vm.resetNavigationFlags();
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F8),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Just a moment...',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(
                value: vm.isUploading ? null : 1.0,
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 12),
            Text(vm.isUploading ? 'Analyzing voice…' : 'Finalizing'),
          ],
        ),
      ),
    );
  }
}