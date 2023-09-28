import 'package:bullet_train/game/game.dart';
import 'package:bullet_train/shared/difficulty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/helpers.dart';

void main() {
  group('GamePage', () {
    testWidgets('is routable', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpApp(
          Builder(
            builder: (context) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).push(
                  GamePage.route(difficulty: Difficulty.easy),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
        expect(find.byType(GamePage), findsOneWidget);
      });
    });

    testWidgets('renders GameView', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpApp(const GamePage(difficulty: Difficulty.easy));
        expect(find.byType(GameView), findsOneWidget);
      });
    });
  });
}
