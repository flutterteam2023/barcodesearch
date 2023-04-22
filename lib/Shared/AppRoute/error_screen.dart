import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.exception, super.key});
  final Exception? exception;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(exception.toString())),
    );
  }
}
