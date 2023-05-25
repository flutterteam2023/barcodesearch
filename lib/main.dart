import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/firebase_options.dart';
import 'package:barcodesearch/locator.dart';
import 'package:barcodesearch/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarColor: const Color(0xFFFFFFFF),
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await initialization(null);
  await MyUser().getUserData;
  setupLocator();
  runApp(const MyApp());
}

Future<void> initialization(BuildContext? context) async {
  await Future.delayed(const Duration(microseconds: 100), () {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Team',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}
