import 'package:treina_app/modules/domain/models/history_item_model.dart';

class CurrentStatus extends UpsHistoryItem {
  CurrentStatus({
    required super.inputVoltage,
    required super.outputVoltage,
    required super.power,
    required super.frequency,
    required super.connection,
    required super.temperature,
    required super.battery,
  });

  String get connectionText {
    return switch (connection) {
      'S' => 'Conectado',
      'N' => 'Desconectado',
      _ => 'Desconectado',
    };
  }
}
