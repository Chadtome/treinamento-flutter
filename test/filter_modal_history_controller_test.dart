//import 'package:flutter/material.dart';
//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treina_app/app/pages/filters/controllers/filter_modal_history_controller.dart';
import 'package:treina_app/app/pages/ups_history/modules/filters/ups_history_filter.dart';

void main() {
  group('HistoryFilterModalController', () {
    test('deve clonar o filtro inicial', () {
      final original = HistoryFilter(status: 'Falha');

      final controller = HistoryFilterModalController(initialFilter: original);

      expect(controller.editingFilter.status, 'Falha');
      expect(identical(controller.editingFilter, original), false);
    });
    //--------------------------------------------------------------------------
    test('deve preencher controllers ao iniciar com datas', () {
      final filter = HistoryFilter(startDate: DateTime(2026, 2, 25));

      final controller = HistoryFilterModalController(initialFilter: filter);

      expect(controller.startDateController.text, '25/02/2026');
    });

    //--------------------------------------------------------------------------

    test('deve atualizar startDate ao mudar texto do controller', () {
      final controller = HistoryFilterModalController(initialFilter: HistoryFilter());

      controller.startDateController.text = '10/03/2026';

      expect(controller.editingFilter.startDate, DateTime(2026, 3, 10));
    });

    //--------------------------------------------------------------------------

    test('clear deve limpar o filtro e controllers', () {
      final filter = HistoryFilter(status: 'Falha');

      final controller = HistoryFilterModalController(initialFilter: filter);

      controller.clear();

      expect(controller.editingFilter.isEmpty, true);
      expect(controller.startDateController.text, '');
    });

    //--------------------------------------------------------------------------

    test('onStatusChanged deve limpar actionArea', () {
      final filter = HistoryFilter(status: 'Falha', actionArea: 'Bateria');

      final controller = HistoryFilterModalController(initialFilter: filter);

      controller.onStatusChanged('Alerta');

      expect(controller.editingFilter.status, 'Alerta');
      expect(controller.editingFilter.actionArea, null);
    });

    //--------------------------------------------------------------------------

    test('onActionAreaChanged deve atualizar actionArea', () {
      final controller = HistoryFilterModalController(initialFilter: HistoryFilter());

      controller.onActionAreaChanged('Bateria');

      expect(controller.editingFilter.actionArea, 'Bateria');
    });

    //--------------------------------------------------------------------------

    test('deve notificar listeners ao mudar status', () {
      final controller = HistoryFilterModalController(initialFilter: HistoryFilter());

      var notified = false;

      controller.addListener(() {
        notified = true;
      });

      controller.onStatusChanged('Alerta');

      expect(notified, true);
    });

    //--------------------------------------------------------------------------

    test('deve atualizar endDate ao mudar texto do controller', () {
      final controller = HistoryFilterModalController(initialFilter: HistoryFilter());

      controller.endDateController.text = '15/03/2026';

      expect(controller.editingFilter.endDate, DateTime(2026, 3, 15));
    });

    //--------------------------------------------------------------------------

    test('deve atualizar startTime ao mudar texto', () {
      final controller = HistoryFilterModalController(initialFilter: HistoryFilter());

      controller.startTimeController.text = '10:30';

      expect(controller.editingFilter.startTime, const TimeOfDay(hour: 10, minute: 30));
    });

    //--------------------------------------------------------------------------

    test('deve atualizar endTime ao mudar texto', () {
      final controller = HistoryFilterModalController(initialFilter: HistoryFilter());

      controller.endTimeController.text = '10:30';

      expect(controller.editingFilter.endTime, const TimeOfDay(hour: 10, minute: 30));
    });

    //--------------------------------------------------------------------------

    test('dispose não deve lançar erro', () {
      final controller = HistoryFilterModalController(initialFilter: HistoryFilter());

      controller.dispose();

      expect(true, true); // apenas garante que não crashou
    });

    //--------------------------------------------------------------------------
  });
}
