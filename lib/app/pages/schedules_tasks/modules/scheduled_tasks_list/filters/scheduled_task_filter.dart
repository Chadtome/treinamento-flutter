import 'package:flutter/material.dart';

class ScheduledTaskFilter {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? event;
  String? frequency;

  ScheduledTaskFilter({this.startDate, this.endDate, this.startTime, this.endTime, this.event, this.frequency});

  bool get isEmpty => startDate == null && endDate == null && startTime == null && endTime == null && event == null && frequency == null;

  void clear() {
    startDate = null;
    endDate = null;
    startTime = null;
    endTime = null;
    event = null;
    frequency = null;
  }

  ScheduledTaskFilter copyWith({DateTime? startDate, DateTime? endDate, TimeOfDay? startTime, TimeOfDay? endTime, String? event, String? frequency}) {
    return ScheduledTaskFilter(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      event: event ?? this.event,
      frequency: frequency ?? this.frequency,
    );
  }

  ScheduledTaskFilter clone() {
    return copyWith();
  }
}
