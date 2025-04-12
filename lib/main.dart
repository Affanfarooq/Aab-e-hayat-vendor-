import 'dart:developer';
import 'package:aabehayat_vendor/Controllers/AuthController.dart';
import 'package:aabehayat_vendor/Services/NotificationService.dart';
import 'package:aabehayat_vendor/Views/BottomNavBar.dart';
import 'package:aabehayat_vendor/Views/RequestApprovalScreen.dart';
import 'package:aabehayat_vendor/Views/WelcomeScreen.dart';
import 'package:aabehayat_vendor/firebase_options.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.requestNotificationPermissions();
  await getFCMToken();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final authController = Get.put(AuthController());
  await authController.checkLoginStatus();

  Widget initialScreen;
  if (authController.isLoggedIn.value &&
      authController.isRequestApproved.value) {
    initialScreen = MainScreen();
  } else if (authController.isLoggedIn.value &&
      !authController.isRequestApproved.value) {
    initialScreen = RequestApprovalScreen();
  } else {
    initialScreen = WelcomeScreen();
  }

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatefulWidget {
  final Widget initialScreen;

  const MyApp({super.key, required this.initialScreen});

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
      home: widget.initialScreen,
    );
  }
}

Future<void> getFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  log("FCM Token: $token");
}
