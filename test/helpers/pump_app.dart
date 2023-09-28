import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';


extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
  }) {
    return pumpWidget(
      MaterialApp(
        home: navigator != null
            ? MockNavigatorProvider(navigator: navigator, child: widget)
            : widget,
      ),
    );
  }
}
