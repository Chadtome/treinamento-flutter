// enum ScheduledFrequency {
//   immediately(label: 'Imediatamente', code: 0),
//   once(label: 'Uma vez', code: 1),
//   daily(label: 'Diariamente', code: 2),
//   weekly(label: 'Semanalmente', code: 3),
//   monthlhy(label: 'Mensalmente', code: 4);

//   bool isEqual(ScheduledFrequency value) => this == value;

//   const ScheduledFrequency({required this.label, required this.code});

//   final String label;

//   final int code;

//   static ScheduledFrequency fromCode(int code) => values.firstWhere((e) => e.code == code);
// }

// class Task {
//   String? id;
//   int? internalId;
//   ScheduleEvent? event;
//   ScheduledFrequency? frequency;
//   String? date;
//   int? minutes;
//   String? weekday;

//   DateTime? creationDate;

//   Task({this.id, this.internalId, this.event, this.frequency, this.date, this.minutes, this.weekday, this.creationDate});

//   factory Task.fromApiResponse(Map<String, dynamic> map) {
//     return Task(
//       id: map['id'] as String?,
//       internalId: map['internalId'] as int?,
//       event: ScheduleEvent.fromCode(map['event'] as int),
//       frequency: ScheduledFrequency.fromCode(map['frequency'] as int),
//       date: map['date'] as String?,
//       minutes: map['minutes'] as int?,
//       weekday: map['weekday'] as String?,
//       creationDate: DateTime.parse(map['createdAt']),
//     );
//   }
// }

// enum ScheduleEvent {
//   quickTest(label: 'Teste bateria (10s)', description: 'Teste bateria (10s)', code: 0),
//   minutesTest(label: 'Testar bateria por', description: 'Teste bateria (minutos)', code: 1),
//   lowBatteryTest(label: 'Teste bateria (autonomia baixa)', description: 'Teste bateria (autonomia baixa)', code: 2),
//   shutdownPC(label: 'Desligar PC', description: 'Desligar PC', code: 3),
//   shutdownUPS(label: 'Desligar UPS', description: 'Desligar UPS', code: 4),
//   restartUPS(label: 'Reiniciar UPS', description: 'Reiniciar UPS', code: 5),
//   shutdownPCAndNobreak(label: 'Desligar PC + UPS', description: 'Desligar PC + UPS', code: 6),
//   shutdownPCAndRestartNobreak(label: 'Desligar PC + Reiniciar UPS', description: 'Desligar PC + Reiniciar UPS', code: 7),
//   enableBeep(label: 'Ativar bipe', description: 'Ativar bipe', code: 8),
//   disableBeep(label: 'Desativar bipe', description: 'Desativar bipe', code: 9),
//   cancel(label: 'Evento cancelado', description: 'Evento cancelado', code: 10);

//   const ScheduleEvent({required this.description, required this.code, required this.label});

//   final String description;

//   final String label;

//   final int code;

//   bool isEqual(ScheduleEvent value) => this == value;

//   bool get isTest => this == ScheduleEvent.quickTest || this == ScheduleEvent.minutesTest || this == ScheduleEvent.lowBatteryTest;

//   bool get isBeep => this == enableBeep || this == disableBeep;

//   static ScheduleEvent fromCode(int code) => values.firstWhere((e) => e.code == code);
// }
