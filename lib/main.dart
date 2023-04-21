import 'package:barcodesearch/counter.dart';
import 'package:barcodesearch/firebase_options.dart';
import 'package:barcodesearch/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      title: 'Flutter Team',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter TEAM hjhj'),
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
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ProductList().add(
            ProductModel(name: "adasdas", price: 123123),
          );
          await FirebaseFirestore.instance.collection("products").doc().set(
                ProductModel(name: "adasdas", price: 123123).toMap(),
              );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
