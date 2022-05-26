import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_scheduler/commands/bootstrap_command.dart';
import 'package:vaccine_scheduler/models/app_models.dart';
import 'package:vaccine_scheduler/screens/splash_screen_page.dart';
import 'package:vaccine_scheduler/services/app_service.dart';
import 'package:vaccine_scheduler/services/notifciation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppModel()),
        Provider(create: (_) => AppService()),
        Provider(create: (_) => NotificationService()),
      ],
      builder: (context, _) {
        BootstrapCommand().run(context);
        return MaterialApp(
          title: 'Vaccine Scheduler',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Scaffold(
            body: SplashScreenPage(),
          ),
        );
      },
    );
  }
}

void init() {
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
}
