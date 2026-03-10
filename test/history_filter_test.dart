//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treina_app/app/pages/ups_history/modules/filters/ups_history_filter.dart';

void main() {
  group('HistoryFilter', () {
    test('isEmpty deve ser true quando for criado sem valores', () {
      final filter = HistoryFilter();

      expect(filter.isEmpty, true);
    });

    test('isEmpty deve ser false quando qualquer campo estiver preenchido', () {
      final filter = HistoryFilter(status: 'Falha');

      expect(filter.isEmpty, false);
    });

    //--------------------------------------------------------------------------

    test('clear deve limpar todos os campos', () {
      final filter = HistoryFilter(
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        status: 'Falha',
        actionArea: 'Bateria',
      );

      filter.clear();

      expect(filter.startDate, null);
      expect(filter.endDate, null);
      expect(filter.startTime, null);
      expect(filter.endTime, null);
      expect(filter.status, null);
      expect(filter.actionArea, null);
      expect(filter.isEmpty, true);
    });

    //--------------------------------------------------------------------------

    test('copyWith deve manter valores antigos quando não informados', () {
      final original = HistoryFilter(status: 'Falha', actionArea: 'Bateria');

      final copy = original.copyWith();

      expect(copy.status, 'Falha');
      expect(copy.actionArea, 'Bateria');
    });

    //--------------------------------------------------------------------------

    test('copyWith deve sobescrever apenas os valores informado', () {
      final original = HistoryFilter(status: 'Falha');

      final copy = original.copyWith(status: 'Alerta');

      expect(copy.status, 'Alerta');
    });

    //--------------------------------------------------------------------------

    test('clone deve criar nova instancia com mesmos valores', () {
      final original = HistoryFilter(status: 'Falha');

      final cloned = original.clone();

      expect(cloned.status, 'Falha');
      expect(identical(original, cloned), false);
    });
  });
}
