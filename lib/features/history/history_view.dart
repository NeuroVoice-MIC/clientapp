import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  Future<void> _clearHistory(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Clear History"),
        content: const Text(
          "This will permanently delete all past test results. "
          "This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Clear",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final box = Hive.box('voice_results');
      await box.clear();
    }
  }

  Color _riskColor(String level) {
    switch (level) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  IconData _riskIcon(String level) {
    switch (level) {
      case "High":
        return Icons.warning;
      case "Medium":
        return Icons.info_outline;
      default:
        return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('voice_results');

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: "Clear history",
            onPressed: () => _clearHistory(context),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (_, Box box, __) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No history yet",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: box.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, index) {
              final item = box.getAt(index);

              final double riskScore =
                  (item['riskScore'] as num).toDouble();
              final String riskLevel = item['riskLevel'] as String;

              // 👇 NEW: test type flag (safe default for old data)
              final String testType =
                  (item['testType'] ?? 'voice').toString();

              final DateTime time =
                  DateTime.parse(item['timestamp']).toLocal();

              final Color accent = _riskColor(riskLevel);

              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _riskIcon(riskLevel),
                    color: accent,
                  ),
                ),
                title: Text(
                  "Risk Level: $riskLevel",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Score: ${(riskScore * 100).toStringAsFixed(1)}%",
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Test: ${testType.toUpperCase()}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  "${time.day}/${time.month}/${time.year}\n"
                  "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}