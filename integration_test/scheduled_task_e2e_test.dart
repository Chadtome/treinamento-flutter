import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:treina_app/main.dart' as app;

// import 'history_navigation_e2e_test.dart' as app;
import 'robots/app_robots.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Fluxo Navegação - Tarefas agendadas', () {
    testWidgets('Fluxo completo', (tester) async {
      app.main();

      await tester.pump();
      await tester.pumpAndSettle();

      final robot = AppRobot(tester);

      expect(find.byIcon(Icons.dehaze), findsOneWidget);

      await robot.abrirDrawer();
      await robot.abrirPainelControle();
      await robot.abrirAgendamentoTarefas();
      await robot.abrirListaTarefas();

      await robot.clicarNovaTarefa();
      await robot.abrirInfo();
      await robot.criarTarefaImediata();

      await robot.voltar();

      await robot.clicarNovaTarefa();
      await robot.criarTarefaComData();

      await robot.abrirTarefa();

      await robot.alterarContraste();

      await robot.abrirDrawer();
      await robot.abrirPainelControle();
      await robot.abrirAgendamentoTarefas();
      await robot.abrirListaTarefas();

      await robot.editarTarefa();

      await robot.apagarTarefa();
    });
  });
}

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:treina_app/app/pages/home/homepage.dart';
// //import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/page/create_or_edit_task_page.dart';
// //import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/pages/scheduled_tasks_list_page.dart';

// import 'package:treina_app/main.dart' as app;

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   Future<void> pausaVisual(WidgetTester tester) async {
//     //await tester.pump(const Duration(seconds: 2));
//     await tester.pump(const Duration(milliseconds: 300));
//   }

//   group('Fluxo Navegação - Tarefas agendadas', () {
//     testWidgets('Abrir drawer e navegar até tarefas agendadas', (tester) async {
//       app.main();

//       await tester.pump();
//       await tester.pumpAndSettle();

//       expect(find.byIcon(Icons.dehaze), findsOneWidget);

//       //--------Abrir Drawer------------------
//       await tester.tap(find.byIcon(Icons.dehaze));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester); // pausa visual;

//       //---------Expande Painel de Controle--------------------

//       final painel = find.byKey(const Key("drawer_painel-de-controle"));

//       await tester.ensureVisible(painel);
//       await tester.tap(painel);

//       await pausaVisual(tester); // pausa visual;

//       //------------   Expande Agendamento de Tarefas --------------------------

//       await tester.tap(find.byKey(const Key("drawer_agendamento-tarefas")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester); // pausa visual;

//       //------------ Clica na Lista de Tarefas Agendadas -----------------------

//       await tester.tap(find.byKey(const Key("lista-tarefas-agendadas")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //-------- ATÉ ESSE PONTO É A NAVEGAÇÃO PARA A LISTA DE TAREFAS ----------

//       //--------------- Clica no botão "Nova Tarefa" ---------------------------

//       await tester.tap(find.byKey(const Key("botao_nova-tarefa")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //---- ATÉ ESSE PONTO É A NAVEGAÇÃO PARA A CRIAÇÃO DE UMA NOVA TAREFA ----

//       //----------------- BOTÃO INFO DA TELA DE NOVA TAREFA --------------------

//       await tester.tap(find.byKey(const Key("info_button")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.byKey(const Key("botao_ok-info")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //--------------------- IMEDIATAMENTE ------------------------------------

//       final selectionFinder = find.byKey(const Key("freq-imediatamente"));
//       final selectFinder = find.byKey(const Key("ativa-bipe"));

//       final checkboxFinder = find.descendant(of: selectionFinder, matching: find.byType(Checkbox));
//       final checkinFinder = find.descendant(of: selectFinder, matching: find.byType(Checkbox));

//       await tester.tap(checkboxFinder);
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(checkinFinder);
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.byKey(const Key("schedule_button")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("OK"));
//       await tester.pumpAndSettle();

//       await tester.pump(const Duration(seconds: 4));

//       await tester.tap(find.byIcon(Icons.arrow_back));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //------------------ DIARIAMENTE -----------------------------------------

//       //--------------- Clica no botão "Nova Tarefa" ---------------------------

//       await tester.tap(find.byKey(const Key("botao_nova-tarefa")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //------------------------------------------------------------------------

//       final selection1 = find.byKey(const Key("freq-uma-vez"));
//       final selection2 = find.byKey(const Key("even-desl-pc-ups"));

//       final checkbox1 = find.descendant(of: selection1, matching: find.byType(Checkbox));
//       final checkbox2 = find.descendant(of: selection2, matching: find.byType(Checkbox));

//       await tester.tap(checkbox1);
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //---------selecionar DATA

//       await tester.tap(find.byKey(const Key("campo_data")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("OK"));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //--------------selecionar HORA

//       await tester.tap(find.byKey(const Key("campo_hora")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("OK"));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //--------------------------------

//       await tester.tap(checkbox2);
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.byKey(const Key("schedule_button")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("OK"));
//       await tester.pumpAndSettle();

//       await tester.pump(const Duration(seconds: 4));

//       await tester.tap(find.byIcon(Icons.arrow_back));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);
//------------------------------------------------------------------------------
//       await tester.tap(find.text("Tarefa Agendada"));
//       await tester.pumpAndSettle();

//       await tester.pump(const Duration(seconds: 5));

//       await tester.tap(find.byIcon(Icons.arrow_back));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //--------------------------- MENU CONTRASTE -----------------------------
//       await tester.tap(find.byIcon(Icons.dehaze));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester); // pausa visual;

//       await tester.tap(find.text("Contraste"));
//       await tester.pumpAndSettle();

//       //------------------------------------------------------------------------

//       await tester.tap(find.byIcon(Icons.dehaze));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester); // pausa visual;

//       //---------Expande Painel de Controle--------------------

//       final painel1 = find.byKey(const Key("drawer_painel-de-controle"));

//       await tester.ensureVisible(painel1);
//       await tester.tap(painel1);

//       await pausaVisual(tester); // pausa visual;

//       //------------   Expande Agendamento de Tarefas --------------------------

//       await tester.tap(find.byKey(const Key("drawer_agendamento-tarefas")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester); // pausa visual;

//       //------------ Clica na Lista de Tarefas Agendadas -----------------------

//       await tester.tap(find.byKey(const Key("lista-tarefas-agendadas")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       final cardFinder = find.text("Tarefa Agendada");

//       //----------------------EDITAR TAREFA-------------------------------------

//       await tester.drag(cardFinder, const Offset(-300, 0));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.byKey(const Key("botao-editar")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       final selection3 = find.byKey(const Key("freq-mensal"));
//       final checkbox3 = find.descendant(of: selection3, matching: find.byType(Checkbox));

//       await tester.tap(checkbox3);
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //---------selecionar DATA

//       await tester.tap(find.byKey(const Key("campo_data")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("OK"));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //--------------selecionar HORA

//       await tester.tap(find.byKey(const Key("campo_hora")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("OK"));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //--------------------------------
//       await tester.tap(find.byKey(const Key("schedule_button")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("OK"));
//       await tester.pumpAndSettle();

//       await tester.pump(const Duration(seconds: 4));

//       await tester.tap(find.byIcon(Icons.arrow_back));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       //--------------- APAGAR A TAREFA ----------------------------------------

//       await tester.drag(cardFinder, const Offset(-300, 0));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.byKey(const Key("botao-apagar")));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.text("Desfazer"));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.drag(cardFinder, const Offset(-300, 0));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       await tester.tap(find.byKey(const Key("botao-apagar")));
//       await tester.pumpAndSettle();

//       await tester.pump(const Duration(seconds: 4));

//       await tester.tap(find.byIcon(Icons.arrow_back));
//       await tester.pumpAndSettle();

//       await pausaVisual(tester);

//       expect(find.byType(HomePage), findsOneWidget);

//       //------------------------------------------------------------------------
//     });
//   });
// }
