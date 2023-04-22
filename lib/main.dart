import 'package:barcodesearch/Authentication/login.dart';
import 'package:barcodesearch/Screens/onboardingScreen/dart/onboarding_Screen.dart';
import 'package:barcodesearch/Shared/AppRoute/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:barcodesearch/Models/product_model.dart';
import 'package:barcodesearch/firebase_options.dart';
import 'package:barcodesearch/product_list.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Team',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
            headline4: TextStyle(
                fontSize: 150.0,
                fontFamily: 'Hind',
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w300),
            headline2: TextStyle(
                fontSize: 20.0, fontFamily: 'Hind', color: Color(0xE0FFFFFF)),
            headline3: TextStyle(
                fontSize: 14.0, fontFamily: 'Hind', color: Colors.black54),
            headline1: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontFamily: 'Hind'),
            headline6: TextStyle(
                fontSize: 36.0, color: Colors.white, fontFamily: 'Hind'),
            bodyText2: TextStyle(
                fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
            bodyText1: TextStyle(
                fontSize: 14.0, fontFamily: 'Hind', color: Colors.white)),
        appBarTheme:
            AppBarTheme(backgroundColor: Color.fromARGB(255, 33, 33, 33)),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.orange,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            disabledBackgroundColor: Colors.red,
            shadowColor: Colors.green,
            side: BorderSide(color: Colors.grey),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.purple,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: OnboardingScreen(),

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
