import 'package:flutter/material.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Results")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 16),
            Text("Low Risk", style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text("Score: 94/100"),
          ],
        ),
      ),
    );
  }
}