import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AppRobot {
  final WidgetTester tester;

  AppRobot(this.tester);
  //------------------------------------------------------------------------------
  Future<void> pausa() async {
    await tester.pump(const Duration(milliseconds: 300));
  }

  //------------------------------------------------------------------------------
  Future<void> abrirDrawer() async {
    await tester.tap(find.byIcon(Icons.dehaze));
    await tester.pumpAndSettle();
    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> abrirPainelControle() async {
    final painel = find.byKey(const Key("drawer_painel-de-controle"));

    await tester.ensureVisible(painel);
    await tester.tap(painel);

    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> abrirAgendamentoTarefas() async {
    await tester.tap(find.byKey(const Key("drawer_agendamento-tarefas")));
    await tester.pumpAndSettle();
    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> abrirListaTarefas() async {
    await tester.tap(find.byKey(const Key("lista-tarefas-agendadas")));
    await tester.pumpAndSettle();
    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> clicarNovaTarefa() async {
    await tester.tap(find.byKey(const Key("botao_nova-tarefa")));
    await tester.pumpAndSettle();
    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> abrirInfo() async {
    await tester.tap(find.byKey(const Key("info_button")));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.byKey(const Key("botao_ok-info")));
    await tester.pumpAndSettle();

    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> voltar() async {
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> criarTarefaImediata() async {
    final selectionFinder = find.byKey(const Key("freq-imediatamente"));
    final selectFinder = find.byKey(const Key("ativa-bipe"));

    final checkboxFinder = find.descendant(of: selectionFinder, matching: find.byType(Checkbox));

    final checkinFinder = find.descendant(of: selectFinder, matching: find.byType(Checkbox));

    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(checkinFinder);
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.byKey(const Key("schedule_button")));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 4));
  }

  //------------------------------------------------------------------------------
  Future<void> criarTarefaComData() async {
    final selection1 = find.byKey(const Key("freq-uma-vez"));
    final selection2 = find.byKey(const Key("even-desl-pc-ups"));

    final checkbox1 = find.descendant(of: selection1, matching: find.byType(Checkbox));

    final checkbox2 = find.descendant(of: selection2, matching: find.byType(Checkbox));

    await tester.tap(checkbox1);
    await tester.pumpAndSettle();

    await pausa();

    await selecionarData();
    await selecionarHora();

    await tester.tap(checkbox2);
    await tester.pumpAndSettle();

    await pausa();

    await salvarTarefa();
  }

  //------------------------------------------------------------------------------
  Future<void> selecionarData() async {
    await tester.tap(find.byKey(const Key("campo_data")));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> selecionarHora() async {
    await tester.tap(find.byKey(const Key("campo_hora")));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    await pausa();
  }

  //------------------------------------------------------------------------------
  Future<void> salvarTarefa() async {
    await tester.tap(find.byKey(const Key("schedule_button")));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 4));

    await voltar();
  }

  //------------------------------------------------------------------------------
  Future<void> abrirTarefa() async {
    final tarefa = find.text("Tarefa Agendada");

    //await tester.pumpAndSettle();

    await tester.tap(tarefa);
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 5));

    await voltar();
  }

  //------------------------------------------------------------------------------
  Future<void> alterarContraste() async {
    await abrirDrawer();

    await tester.tap(find.text("Contraste"));
    await tester.pumpAndSettle();
  }

  //------------------------------------------------------------------------------
  Future<void> editarTarefa() async {
    final cardFinder = find.text("Tarefa Agendada");

    await tester.drag(cardFinder, const Offset(-300, 0));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.byKey(const Key("botao-editar")));
    await tester.pumpAndSettle();

    await pausa();

    final selection3 = find.byKey(const Key("freq-mensal"));

    final checkbox3 = find.descendant(of: selection3, matching: find.byType(Checkbox));

    await tester.tap(checkbox3);
    await tester.pumpAndSettle();

    await pausa();

    await selecionarData();
    await selecionarHora();

    await salvarTarefa();
  }

  //------------------------------------------------------------------------------
  Future<void> apagarTarefa() async {
    final cardFinder1 = find.text("Tarefa Agendada");

    await tester.drag(cardFinder1, const Offset(-300, 0));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.byKey(const Key("botao-apagar")));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.text("Desfazer"));
    await tester.pumpAndSettle();

    await pausa();

    await tester.drag(cardFinder1, const Offset(-300, 0));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.byKey(const Key("botao-apagar")));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 4));

    await voltar();
  }

  //------------------------------------------------------------------------------

  Future<void> selecionarDia() async {
    await tester.tap(find.byKey(const Key('weekday_seg')));
    await tester.pumpAndSettle();

    await pausa();

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    await pausa();
  }

  //----------------------------------------------------------------------------
}
