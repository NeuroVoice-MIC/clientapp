import 'package:clientapp/features/history/history_view.dart';
import 'package:clientapp/features/shell/main_shell_view.dart';
import 'package:flutter/material.dart';
import '../../features/onboarding/onboarding_view.dart';
import '../../features/voice_check/voice_check_view.dart';
import '../../features/processing/processing_view.dart';
import '../../features/results/results_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case '/home':
        return MaterialPageRoute(builder: (_) => const MainShellView());
      case '/voice':
        return MaterialPageRoute(builder: (_) => const VoiceCheckView());
      case '/processing':
        return MaterialPageRoute(
          builder: (_) => const ProcessingView(),
          settings: settings,
        );
      case '/results':
        return MaterialPageRoute(
          builder: (_) => const ResultsView(),
          settings: settings, // ✅ THIS LINE FIXES EVERYTHING
        );
      case '/history':
        return MaterialPageRoute(builder: (_) => const HistoryView());
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
    }
  }
}
