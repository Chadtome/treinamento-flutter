enum Severity { none, alert, danger }

class UpsHistoryItem {
  double inputVoltage;
  double outputVoltage;
  double power;
  double frequency;
  String connection;
  double temperature;
  double battery;

  UpsHistoryItem({
    required this.inputVoltage,
    required this.outputVoltage,
    required this.power,
    required this.frequency,
    required this.connection,
    required this.temperature,
    required this.battery,
  });

  Severity InputVoltageSeverity() {
    return switch (inputVoltage) {
      >= 126 && <= 128 => Severity.none,
      (> 123 && <= 126) || (>= 129 && < 131) => Severity.alert,
      _ => Severity.danger,
    };
  }

  Severity PowerSeverity() {
    return switch (power) {
      <= 70 => Severity.none,
      > 70 && < 90 => Severity.alert,
      _ => Severity.danger,
    };
  }

  Severity FrequencySeverity() {
    return switch (frequency) {
      >= 59.0 && <= 61.0 => Severity.none,
      (> 57.0 && < 59.0) || (> 61.0 && < 63.0) => Severity.alert,
      _ => Severity.danger,
    };
  }

  Severity ConnectionSeverity() {
    return switch (connection) {
      'S' => Severity.none,
      'N' => Severity.danger,
      _ => Severity.danger,
    };
  }

  Severity TemperatureSeverity() {
    return switch (temperature) {
      <= 75 => Severity.none,
      > 75 && < 85 => Severity.alert,
      _ => Severity.danger,
    };
  }

  Severity BatterySeverity() {
    return switch (battery) {
      >= 50 => Severity.none,
      >= 20 && < 50 => Severity.alert,
      _ => Severity.danger,
    };
  }
}
