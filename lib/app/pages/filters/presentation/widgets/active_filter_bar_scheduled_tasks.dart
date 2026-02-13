import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/filters/scheduled_task_filter.dart';
import 'package:treina_app/app/presentation/widgets/active_filters_bar_widget.dart';

class ScheduledTaskActiveFiltersBuilder {
  static List<ActiveFilterItem> build({
    required BuildContext context,
    required ScheduledTaskFilter filter,
    required VoidCallback onRemoveEvent,
    required VoidCallback onRemoveFrequency,
    required VoidCallback onRemoveDate,
    required VoidCallback onRemoveTime,
  }) {
    final list = <ActiveFilterItem>[];

    //----------------------------- EVENTO -----------------------------
    if (filter.event != null && filter.event!.isNotEmpty) {
      list.add(ActiveFilterItem(label: filter.event!, onRemove: onRemoveEvent));
    }

    //----------------------------- FREQUÊNCIA --------------------------
    if (filter.frequency != null && filter.frequency!.isNotEmpty) {
      list.add(ActiveFilterItem(label: filter.frequency!, onRemove: onRemoveFrequency));
    }

    //----------------------------- DATA --------------------------------
    final startDate = filter.startDate;
    final endDate = filter.endDate;

    if (startDate != null || endDate != null) {
      String label;

      if (startDate != null && endDate != null) {
        label = '${_formatDate(startDate)} a ${_formatDate(endDate)}';
      } else if (startDate != null) {
        label = '>${_formatDate(startDate)}';
      } else {
        label = '<${_formatDate(endDate!)}';
      }

      list.add(ActiveFilterItem(label: label, onRemove: onRemoveDate));
    }

    //----------------------------- HORA --------------------------------
    final startTime = filter.startTime;
    final endTime = filter.endTime;

    if (startTime != null || endTime != null) {
      String label;

      if (startTime != null && endTime != null) {
        label = '${_formatTime(startTime)} a ${_formatTime(endTime)}';
      } else if (startTime != null) {
        label = '>${_formatTime(startTime)}';
      } else {
        label = '<${_formatTime(endTime!)}';
      }

      list.add(ActiveFilterItem(label: label, onRemove: onRemoveTime));
    }

    return list;
  }

  //----------------------------- FORMAT DATE -----------------------------

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  //----------------------------- FORMAT TIME -----------------------------

  static String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }
}
