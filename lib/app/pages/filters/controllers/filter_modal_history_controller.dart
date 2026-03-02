import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/ups_history/modules/filters/ups_history_filter.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/widget/choose_status_controller.dart';

class HistoryFilterModalController extends ChangeNotifier {
  final HistoryFilter editingFilter;

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  HistoryFilterModalController({required HistoryFilter initialFilter}) : editingFilter = initialFilter.clone() {
    _init();
  }

  //------------------------------INIT------------------------------------------

  void _init() {
    if (editingFilter.startDate != null) {
      startDateController.text = _formatDate(editingFilter.startDate!);
    }

    if (editingFilter.endDate != null) {
      endDateController.text = _formatDate(editingFilter.endDate!);
    }

    if (editingFilter.startTime != null) {
      startTimeController.text = _formatTime(editingFilter.startTime!);
    }

    if (editingFilter.endTime != null) {
      endTimeController.text = _formatTime(editingFilter.endTime!);
    }

    startDateController.addListener(() {
      editingFilter.startDate = _parseDate(startDateController.text);
      notifyListeners();
    });

    endDateController.addListener(() {
      editingFilter.endDate = _parseDate(endDateController.text);
      notifyListeners();
    });

    startTimeController.addListener(() {
      editingFilter.startTime = _parseTime(startTimeController.text);
      notifyListeners();
    });

    endTimeController.addListener(() {
      editingFilter.endTime = _parseTime(endTimeController.text);
      notifyListeners();
    });
  }

  //-----------------------------------FORMAT-----------------------------------

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  //---------------------------------PARSE--------------------------------------

  DateTime? _parseDate(String value) {
    if (value.isEmpty) return null;

    try {
      final parts = value.split('/');
      if (parts.length != 3) return null;

      return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    } catch (_) {
      return null;
    }
  }

  TimeOfDay? _parseTime(String value) {
    if (value.isEmpty) return null;

    try {
      final parts = value.split(':');
      if (parts.length != 2) return null;

      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {
      return null;
    }
  }

  //----------------------------------------------------------------------------
  List<String> get allParameterOptions {
    final options = List<String>.from(actionAreaOptions);
    return options;
  }

  //----------------------------------------------------------------------------

  void onStatusChanged(String value) {
    editingFilter.status = value;
    editingFilter.actionArea = null;
    notifyListeners();
  }

  //----------------------------------------------------------------------------

  void onActionAreaChanged(String value) {
    editingFilter.actionArea = value;
    notifyListeners();
  }

  //------------------------------------------------------------------------------

  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();

    super.dispose();
  }

  //----------------------------------------------------------------------------

  void clear() {
    editingFilter.clear();

    startDateController.clear();
    endDateController.clear();
    startTimeController.clear();
    endTimeController.clear();

    notifyListeners();
  }
}
