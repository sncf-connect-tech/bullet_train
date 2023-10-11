import 'package:bullet_train/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders App', (tester) async {
      await tester.pumpWidget(const App());

      await tester.pumpAndSettle(const Duration(seconds: 400));
      expect(find.byType(App), findsOneWidget);
    });
  });
}
