import 'dart:async';
import 'package:clientapp/core/utils/audio_helper.dart';
import 'package:flutter/material.dart';

class VoiceCheckViewModel extends ChangeNotifier {
  final AudioRecorderService _audioService = AudioRecorderService();

  Timer? _timer;
  int remainingSeconds = 12;
  String? recordedFilePath;
  bool _isRecording = false;

  Future<void> startRecording() async {
    if (_isRecording) return;

    remainingSeconds = 12;
    notifyListeners();

    recordedFilePath = await _audioService.startRecording();
    _isRecording = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingSeconds <= 0) {
        await stopRecording();
      } else {
        remainingSeconds--;
        notifyListeners();
      }
    });
  }

  Future<void> stopRecording() async {
    if (!_isRecording) return;

    _timer?.cancel();
    _timer = null;

    recordedFilePath = await _audioService.stopRecording();
    _isRecording = false;

    debugPrint('WAV file saved at: $recordedFilePath');
    notifyListeners();
  }

  String get formattedTime {
    return '00:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioService.dispose();
    super.dispose();
  }
}
