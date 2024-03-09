import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/no_internet_view.dart';
import 'package:united_proposals_app/controller/provider/affiliate_provider.dart';
import 'package:united_proposals_app/controller/provider/chat_provider.dart';
import 'package:united_proposals_app/controller/provider/location_provider.dart';
import 'package:united_proposals_app/controller/provider/noti_provider.dart';
import 'package:united_proposals_app/routes/app_routes.dart';
import 'package:united_proposals_app/view/notification/view/notification_view.dart';

import 'controller/provider/auth_provider.dart';
import 'controller/provider/root_provider.dart';
import 'view/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            // storageBucket:
            //     "https://console.firebase.google.com/project/united-proposal/storage/united-proposal.appspot.com/files",
            apiKey: "AIzaSyDxkA5wYh0NbNWWcAISCCniv3wkmZvcE7s",
            appId: "1:700226995625:web:3f3e0ec30fc85d83a930b8",
            messagingSenderId: "700226995625",
            projectId: "united-proposal"));
  }
  await Firebase.initializeApp();
  // await FirebaseApi().initNotification();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthVM()),
      ChangeNotifierProvider(create: (context) => RootProvider()),
      ChangeNotifierProvider(create: (context) => AffiliateProvider()),
      ChangeNotifierProvider(create: (context) => NotiProvider()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {}

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _connectionStatus = "Unknown";
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      startConnectionStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: SplashScreenAdmin(),
    //   debugShowCheckedModeBanner: false,
    // );
    return Sizer(builder: (context, orientation, deviceType) {
      // return MaterialApp(
      //   home: SplashScreenAdmin(),
      //   debugShowCheckedModeBanner: false,
      // );
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetMaterialApp(
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'United Proposal',
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.route,
          navigatorKey: navigatorKey,
          getPages: AppPages.pages,
          routes: {
            '/notification_screen': (context) => const NotificationView(),
          },
          // initialRoute: RootScreen.route,
        ),
      );
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        {
          debugPrint(result.toString());
          debugPrint(_connectionStatus);
        }
        break;
      case ConnectivityResult.mobile:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.none:
        {
          Get.snackbar("uh_oh", "no_internet_connection");
          Get.to(() => const NoInternetScreen());
        }
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        break;
    }
  }

  void startConnectionStream() {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
}
