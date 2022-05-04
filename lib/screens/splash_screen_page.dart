import 'package:flutter/material.dart';
import 'package:vaccine_scheduler/screens/home.dart';
import 'package:vaccine_scheduler/screens/onboarding_page.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO change to future
    final Future<bool> _isFreshInstall = Future.value(false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<bool>(
        future: _isFreshInstall,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data == false) {
              return const HomePage();
            }
            return const OnboardingPage();
          }

          return const Center(
            child: Text("Vaccination Scheduler"),
          );
        },
      ),
    );
  }
}
