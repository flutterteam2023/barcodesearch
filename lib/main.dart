import 'package:barcodesearch/features/Searching/Models/product_model.dart';
import 'package:barcodesearch/features/Onboarding/onboarding_screen.dart';
import 'package:barcodesearch/routing/routes.dart';
import 'package:barcodesearch/features/Authentication/Values/my_user.dart';
import 'package:barcodesearch/firebase_options.dart';
import 'package:barcodesearch/features/Searching/Values/product_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MyUser().getUserData;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder:(context,orientation,deviceType) {
        return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Team',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
        headlineMedium: TextStyle(
        fontSize: 150,
        fontFamily: 'Hind',
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w300,
        ),
        displayMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Hind',
        color: Color(0xE0FFFFFF),
        ),
        displaySmall: TextStyle(
        fontSize: 14,
        fontFamily: 'Hind',
        color: Colors.black54,
        ),
        displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w300,
        color: Colors.black,
        fontFamily: 'Hind',
        ),
        titleLarge: TextStyle(
        fontSize: 36,
        color: Colors.white,
        fontFamily: 'Hind',
        ),
        bodyMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Hind',
        color: Colors.black,
        ),
        bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: 'Hind',
        color: Colors.white,
        ),
        ),
        appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromARGB(255, 33, 33, 33)),
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

        );} );
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
