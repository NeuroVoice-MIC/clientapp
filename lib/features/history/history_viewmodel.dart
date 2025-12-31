import 'package:clientapp/features/history/history_service.dart';
import 'package:flutter/material.dart';


class HistoryViewModel extends ChangeNotifier {
  final List<VoiceTestHistory> _history = [];

  List<VoiceTestHistory> get history => _history;

  HistoryViewModel() {
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    // Simulate backend delay
    await Future.delayed(const Duration(milliseconds: 600));

    _history.clear();
    _history.addAll([
      VoiceTestHistory(
        id: '1',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'Stable',
        score: 94,
      ),
      VoiceTestHistory(
        id: '2',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Change Detected',
        score: 71,
      ),
      VoiceTestHistory(
        id: '3',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        status: 'Stable',
        score: 90,
      ),
    ]);

    notifyListeners();
  }
}