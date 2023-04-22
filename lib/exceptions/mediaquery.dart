import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get laftWidth => MediaQuery.of(this).size.width / 2;
  double get halfHeight => MediaQuery.of(this).size.height / 2;

  //safe areas
  double get safeTop => MediaQuery.of(this).viewPadding.top;
  double get safeBottom => MediaQuery.of(this).viewPadding.bottom;
  double get safeRight => MediaQuery.of(this).viewPadding.right;
  double get safeLeft => MediaQuery.of(this).viewPadding.left;
}
