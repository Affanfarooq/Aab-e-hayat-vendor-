import 'dart:developer';
import 'package:aabehayat_vendor/Services/NotificationService.dart';
import 'package:aabehayat_vendor/Services/ShopAuthService.dart';
import 'package:aabehayat_vendor/Views/BottomNavBar.dart';
import 'package:aabehayat_vendor/Views/Dashboard.dart';
import 'package:aabehayat_vendor/Views/OnboardingScreens.dart';
import 'package:aabehayat_vendor/Views/RequestApprovalScreen.dart';
import 'package:aabehayat_vendor/firebase_options.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.requestNotificationPermissions();
  await getFCMToken();
  await checkAndUpdateRequestStatus();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent, 
    systemNavigationBarIconBrightness: Brightness.light, 
    systemNavigationBarDividerColor: Colors.transparent, 
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isRequestPending = prefs.getBool('isRequestPending') ?? false; 
  bool isRequestApproved = prefs.getBool('isRequestApproved') ?? false; 


  Widget initialScreen;
  if (isRequestPending) {
    initialScreen = RequestApprovalScreen(); 
  } else if (isRequestApproved) {
    initialScreen = MainScreen(); 
  } else {
    initialScreen = OnBoardingScreen(); 
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


Future<void> checkAndUpdateRequestStatus() async {
  final shopData = await ShopService.getShopData();

  if (shopData != null) {
    bool isApproved = shopData['accountApprove'] ?? false;
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isRequestApproved', isApproved);
    await prefs.setBool('isRequestPending', !isApproved);
  }
}

