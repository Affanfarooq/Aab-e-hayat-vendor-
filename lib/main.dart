import 'dart:developer';

import 'package:aabehayat_vendor/Services/NotificationService.dart';
import 'package:aabehayat_vendor/Views/LandingScreen.dart';
import 'package:aabehayat_vendor/Views/OnboardingScreens.dart';
import 'package:aabehayat_vendor/Views/PendingRequestScreen.dart';
import 'package:aabehayat_vendor/Views/SplashScreen.dart';
import 'package:aabehayat_vendor/firebase_options.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.requestNotificationPermissions();
  await getFCMToken();

  runApp(MyApp());
}



Future<void> getFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  log("FCM Token: $token");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   @override
  void initState() {
    super.initState();
    NotificationService.initialize(context);
  }



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreens(),
    );
  }
}
