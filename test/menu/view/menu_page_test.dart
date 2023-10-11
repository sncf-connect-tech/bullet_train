import 'package:bullet_train/menu/view/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('MenuPage', () {
    testWidgets('renders MenuPage', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpApp(const MenuPage());
        await tester.pumpAndSettle();
        expect(find.byType(MenuPage), findsOneWidget);
      });
    });
  });

  group('MenuPage', () {
    testWidgets('renders start button', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpApp(const MenuPage());
        await tester.pumpAndSettle();
        expect(find.byType(ElevatedButton), findsOneWidget);
      });
    });
  });
}
