import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/ups_history/modules/filters/ups_history_filter.dart';
import 'package:treina_app/app/presentation/widgets/active_filters_bar_widget.dart';

class HistoryActiveFiltersBuilder {
  static List<ActiveFilterItem> build({
    required HistoryFilter filter,
    required VoidCallback onRemoveStatus,
    required VoidCallback onRemoveActionArea,
    required VoidCallback onRemoveDate,
    required VoidCallback onRemoveTime,
  }) {
    final list = <ActiveFilterItem>[];

    //--------------------------------------------------------------------------

    if (filter.status != null && filter.status!.isNotEmpty) {
      list.add(ActiveFilterItem(label: filter.status!, onRemove: onRemoveStatus));
    }

    //--------------------------------------------------------------------------

    if (filter.actionArea != null && filter.actionArea!.isNotEmpty) {
      list.add(ActiveFilterItem(label: filter.actionArea!, onRemove: onRemoveActionArea));
    }

    //--------------------------------------------------------------------------

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

    //--------------------------------------------------------------------------

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

  //----------------------------------------------------------------------------

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  static String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }
}
