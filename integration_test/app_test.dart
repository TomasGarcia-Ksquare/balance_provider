import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:balance_provider/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('create_transaction_screen', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder createButton = find.byKey(Key('createButton'));
      await tester.tap(createButton);
      await tester.pumpAndSettle();
    });
  });
}
