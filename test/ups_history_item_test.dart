import 'package:flutter_test/flutter_test.dart';
import 'package:treina_app/modules/domain/models/history_item_model.dart';

void main() {
  //----------------------------------------------------------------------------
  group('InputVoltageSeverity', () {
    test('retorna none quando entre 126 e 128', () {
      final item = UpsHistoryItem(inputVoltage: 127, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 0, battery: 0);

      expect(item.InputVoltageSeverity(), Severity.none);
    });

    test('retorna alert quando acima de 123 e abaixo de 126 ou acima de 129 e abaixo 131', () {
      final item = UpsHistoryItem(inputVoltage: 124, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 0, battery: 0);

      expect(item.InputVoltageSeverity(), Severity.alert);
    });

    test('retorna danger quando fora da faixa', () {
      final item = UpsHistoryItem(inputVoltage: 132, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 0, battery: 0);

      expect(item.InputVoltageSeverity(), Severity.danger);
    });
  });
  //------------------------------------------------------------------------------
  group('PowerSeverity', () {
    test('retorna none quando é 70', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 70, frequency: 0, connection: 'S', temperature: 0, battery: 0);

      expect(item.PowerSeverity(), Severity.none);
    });

    test('retorna alert quando acima de 70 e abaixo de 90', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 75, frequency: 0, connection: 'S', temperature: 0, battery: 0);

      expect(item.PowerSeverity(), Severity.alert);
    });

    test('retorna danger quando fora da faixa', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 95, frequency: 0, connection: 'S', temperature: 0, battery: 0);

      expect(item.PowerSeverity(), Severity.danger);
    });
  });

  //----------------------------------------------------------------------------

  group('FrequencySeverity', () {
    test('retorna none quando entre 59 e 61', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 60, connection: 'S', temperature: 0, battery: 0);

      expect(item.FrequencySeverity(), Severity.none);
    });

    test('retorna alert quando acima de 57 e abaixo de 59 ou acima de 61 e abaixo de 63', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 62, connection: 'S', temperature: 0, battery: 0);

      expect(item.FrequencySeverity(), Severity.alert);
    });

    test('retorna danger quando fora faixa', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 70, connection: 'S', temperature: 0, battery: 0);

      expect(item.FrequencySeverity(), Severity.danger);
    });
  });

  //----------------------------------------------------------------------------

  group('TemperatureSeverity', () {
    test('retorna none quando for abaixo de 75', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 70, battery: 0);

      expect(item.TemperatureSeverity(), Severity.none);
    });

    test('retorna alert quando for acima de 75 e abaixo de 85', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 78, battery: 0);

      expect(item.TemperatureSeverity(), Severity.alert);
    });

    test('retorna danger quando fora da faixa', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 90, battery: 0);

      expect(item.TemperatureSeverity(), Severity.danger);
    });
  });

  //----------------------------------------------------------------------------

  group('BatterySeverity', () {
    test('retorna none quando for acima de 50', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 0, battery: 100);

      expect(item.BatterySeverity(), Severity.none);
    });

    test('retorna alert quando for acima de 20 e abaixo de 50', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 0, battery: 30);

      expect(item.BatterySeverity(), Severity.alert);
    });

    test('retorna danger quando fora da faixa', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 0, battery: 10);

      expect(item.BatterySeverity(), Severity.danger);
    });
  });

  //----------------------------------------------------------------------------

  group('ConnectionSeverity', () {
    test('retorna none quando connection é S', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'S', temperature: 0, battery: 0);

      expect(item.ConnectionSeverity(), Severity.none);
    });

    test('retorna danger quando connection for N', () {
      final item = UpsHistoryItem(inputVoltage: 0, outputVoltage: 0, power: 0, frequency: 0, connection: 'N', temperature: 0, battery: 0);

      expect(item.ConnectionSeverity(), Severity.danger);
    });
  });
}
