import 'package:bullet_train/game/view/game_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('GamePage', () {
    testWidgets('renders GameView', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpApp(const GamePage());
        expect(find.byType(GamePage), findsOneWidget);
      });
    });
  });
}
