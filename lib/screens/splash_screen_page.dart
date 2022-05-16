import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_scheduler/commands/bootstrap_command.dart';
import 'package:vaccine_scheduler/models/app_models.dart';
import 'package:vaccine_scheduler/screens/landing_page.dart';
import 'package:vaccine_scheduler/screens/onboarding_page.dart';
import 'package:vaccine_scheduler/styles.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future<void> future = Future.delayed(const Duration(seconds: 2));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<void>(
        future: future,
        builder: (context, _) {
          if (BootstrapCommand.done()) {
            final isFreshInstall = context.read<AppModel>().isFreshInstall();
            if (isFreshInstall) return const OnboardingPage();
            return const HomePage();
          }
          return Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 400,
            ),
          );
        },
      ),
    );
  }
}
