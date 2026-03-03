import 'package:flutter/material.dart';

class HistoryFilter {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? status;
  String? actionArea;

  HistoryFilter({this.startDate, this.endDate, this.startTime, this.endTime, this.status, this.actionArea});

  bool get isEmpty => startDate == null && endDate == null && startTime == null && endTime == null && status == null && actionArea == null;

  void clear() {
    startDate = null;
    endDate = null;
    startTime = null;
    endTime = null;
    status = null;
    actionArea = null;
  }

  HistoryFilter copyWith({DateTime? startDate, DateTime? endDate, TimeOfDay? startTime, TimeOfDay? endTime, String? status, String? actionArea}) {
    return HistoryFilter(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      actionArea: actionArea ?? this.actionArea,
    );
  }

  HistoryFilter clone() {
    return copyWith();
  }
}
