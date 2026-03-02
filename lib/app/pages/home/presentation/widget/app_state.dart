import 'package:treina_app/modules/domain/models/current_status_model.dart';

class AppState {
  static CurrentStatus currentStatus = CurrentStatus(
    inputVoltage: 127,
    outputVoltage: 120,
    power: 70,
    frequency: 60,
    connection: 'S',
    temperature: 60,
    battery: 45,
  );
}
