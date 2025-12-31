import 'package:flutter/material.dart';
import '../../features/onboarding/onboarding_view.dart';
import '../../features/home/home_view.dart';
import '../../features/voice_check/voice_check_view.dart';
import '../../features/processing/processing_view.dart';
import '../../features/results/results_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/voice':
        return MaterialPageRoute(builder: (_) => const VoiceCheckView());
      case '/processing':
        return MaterialPageRoute(builder: (_) => const ProcessingView());
      case '/results':
        return MaterialPageRoute(builder: (_) => const ResultsView());
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
    }
  }
}