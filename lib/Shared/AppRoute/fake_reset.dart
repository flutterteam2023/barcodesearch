import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FakeReset extends StatefulWidget {
  const FakeReset({super.key});

  @override
  State<FakeReset> createState() => _FakeResetState();
}

class _FakeResetState extends State<FakeReset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fake reset"),
      ),
    );
  }
}
