import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/history_screen_page.dart';
import 'package:treina_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Fluxo Navegação Histórico UPS', () {
    testWidgets('Deve navegar para tela de Histórico via Drawer', (tester) async {
      app.main();

      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      expect(find.byIcon(Icons.dehaze), findsOneWidget);

      // Abre drawer
      await tester.tap(find.byIcon(Icons.dehaze));
      await tester.pumpAndSettle();

      // Expande Painel de Controle
      await tester.tap(find.byKey(const Key("drawer_painel-de-controle")));
      await tester.pumpAndSettle();

      // Clica no Histórico
      await tester.tap(find.byKey(const Key("drawer_historico-ups")));
      await tester.pumpAndSettle();

      expect(find.byType(UpsHistoryScreen), findsOneWidget);
    });
  });
}
