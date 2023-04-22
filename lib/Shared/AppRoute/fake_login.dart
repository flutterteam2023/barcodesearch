import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FakeLogin extends StatefulWidget {
  const FakeLogin({super.key});

  @override
  State<FakeLogin> createState() => _FakeLoginState();
}

class _FakeLoginState extends State<FakeLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fake login"),
      ),
    );
  }
}
