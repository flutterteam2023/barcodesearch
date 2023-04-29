import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:barcodesearch/features/Searching/Values/product_list.dart';
import 'package:barcodesearch/features/Searching/string.dart';
import 'package:barcodesearch/firebase_options.dart';
import 'package:barcodesearch/locator.dart';
import 'package:barcodesearch/routing/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await MyUser().getUserData;
  setupLocator();
  runApp(const MyApp());
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
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              headlineMedium: GoogleFonts.poppins(
                fontSize: 150,
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w300,
              ),
              displayMedium: GoogleFonts.poppins(
                fontSize: 20,
                color: const Color(0xE0FFFFFF),
              ),
              displaySmall: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
              displayLarge: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
              titleLarge: GoogleFonts.poppins(
                fontSize: 36,
                color: Colors.white,
              ),
              bodyMedium: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.black,
              ),
              bodyLarge: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                disabledBackgroundColor: Colors.red,
                shadowColor: Colors.green,
                side: const BorderSide(color: Colors.grey),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.purple,
                backgroundColor: Colors.green,
              ),
            ),
          ),
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: ProductList(),
        builder: (context, _, __) {
          return ListView.builder(
            itemCount: ProductList().length,
            itemBuilder: (context, index) {
              ProductModel product = ProductList().getIndex(index);
              return Text(product.toString());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
