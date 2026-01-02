import 'dart:async';
import 'package:clientapp/core/models/voice_ml_api.dart';
import 'package:flutter/material.dart';
import 'package:clientapp/core/utils/audio_helper.dart';

class VoiceCheckViewModel extends ChangeNotifier {
  final AudioRecorderService _audioService = AudioRecorderService();
  Timer? _timer;

  int remainingSeconds = 12;
  String? recordedFilePath;
  double processProgress = 0.0;

  bool _isRecording = false;
  bool _navigateToProcessing = false;
  bool _navigateToResults = false;
  bool _disposed = false;

  /// ML state
  bool isUploading = false;
  bool? parkinsonsDetected;
  double? confidence;
  String? errorMessage;

  // ===============================
  // GETTERS
  // ===============================

  bool get isRecording => _isRecording;
  bool get shouldNavigateToProcessing => _navigateToProcessing;
  bool get shouldNavigateToResults => _navigateToResults;

  void resetNavigationFlags() {
    _navigateToProcessing = false;
    _navigateToResults = false;
  }

  // ===============================
  // RECORDING
  // ===============================

  Future<void> startRecording() async {
    if (_isRecording) return;

    remainingSeconds = 12;
    errorMessage = null;
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

    if (_disposed || recordedFilePath == null) return;

    // ✅ Navigate to Processing immediately
    _navigateToProcessing = true;
    notifyListeners();

    // Start ML in background
    _uploadAndAnalyze();
  }

  // ===============================
  // BACKEND / ML
  // ===============================

  Future<void> _uploadAndAnalyze() async {
  isUploading = true;
  processProgress = 0.1;
  notifyListeners();

  try {
    // Fake smooth progress while ML runs
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!isUploading) {
        timer.cancel();
        return;
      }
      if (processProgress < 0.9) {
        processProgress += 0.03;
        notifyListeners();
      }
    });

    final response = await VoiceMlApi.uploadWav(
      wavPath: recordedFilePath!,
    );

    parkinsonsDetected = response['parkinsons_detected'];
    confidence = (response['confidence'] as num).toDouble();

    isUploading = false;
    processProgress = 1.0;

    _navigateToResults = true;
    notifyListeners();
  } catch (e) {
    isUploading = false;
    errorMessage = 'Unable to analyze voice.';
    notifyListeners();
  }
}

  // ===============================
  // UI HELPERS
  // ===============================

  String get formattedTime {
    return '00:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // ===============================
  // CLEANUP
  // ===============================

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _audioService.dispose();
    super.dispose();
  }
}