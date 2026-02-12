class ScheduledTaskModel {
  final String id;
  final String title;
  final String frequency;
  final String eventName;
  final DateTime executionDateTime;
  final bool isTestEvent;

  final int? testDurationMinutes;

  ScheduledTaskModel({
    required this.id,
    required this.title,
    required this.frequency,
    required this.eventName,
    required this.executionDateTime,
    required this.isTestEvent,
    this.testDurationMinutes,
  });
}
