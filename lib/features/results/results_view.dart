import 'package:flutter/material.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    debugPrint('ResultsView arguments: $args');

    if (args == null || args is! Map<String, dynamic>) {
      return const _NoResultsView();
    }

    final bool? detected = args['detected'] as bool?;
    final double confidence = (args['confidence'] as num).toDouble();

    return Scaffold(
      appBar: AppBar(title: const Text("Your Results")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              detected == true ? Icons.warning : Icons.check_circle,
              color: detected == true ? Colors.orange : Colors.green,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              detected == true ? "Potential Risk Detected" : "Low Risk",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Confidence: ${(confidence * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoResultsView extends StatelessWidget {
  const _NoResultsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: const Center(
        child: Text(
          "No results available",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
