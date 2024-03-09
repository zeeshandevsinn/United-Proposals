

// import 'dart:ui';

// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:get/get_navigation/src/routes/get_route.dart';
// import 'package:sizer/sizer.dart';
// import 'package:united_proposals_app/view/splash_screen.dart';

// class AdminPanal extends StatelessWidget {
//   const AdminPanal({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//       return GetMaterialApp(
//         title: "United Proposal Panel",
//         navigatorObservers: [BotToastNavigatorObserver()],
//         scrollBehavior: MyCustomScrollBehavior(),
//         fallbackLocale: const Locale('en', 'US'),
//         supportedLocales: const [
//           Locale('en', 'US'),
//         ],
//         debugShowCheckedModeBanner: false,
//         initialRoute: SplashScreen.route,
//         getPages: [
//           GetPage(name: "/", page: () => const SplashScreen()),
//           GetPage(name: SplashScreen.route, page: () => const SplashScreen()),
//           GetPage(name: , page: () => const AuthView()),
//           GetPage(name:, page: () => const DashboardView()),
//         ],
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//       );
//     });
//   }
// }

// class MyCustomScrollBehavior extends MaterialScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       };
// }