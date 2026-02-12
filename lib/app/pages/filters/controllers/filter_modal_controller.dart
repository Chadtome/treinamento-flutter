import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_frequency/choose_frequency_controller.dart' as freq;
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_test_event/choose_test_event_controller.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/filters/scheduled_task_filter.dart';

class FilterModalController extends ChangeNotifier {
  final ScheduledTaskFilter editingFilter;

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  FilterModalController({required ScheduledTaskFilter initialFilter}) : editingFilter = initialFilter.clone() {
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

  //----------------------REGRAS DO MODAL---------------------------------------

  List<String> get frequencyOptions {
    final options = List<String>.from(freq.frequencyOptions);
    options.remove('Imediatamente');

    if (_isTestEvent) {
      options.remove('Diariamente');
    }

    return options;
  }

  bool get _isTestEvent {
    final event = editingFilter.event;
    if (event == null) return false;

    return testEventOptions.contains(event);
  }

  //----------------------------------------------------------------------------

  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  //----------------------------------------------------------------------------

  void onEventChanged(dynamic event) {
    editingFilter.event = event;
    editingFilter.frequency = null;
    notifyListeners();
  }

  //----------------------------------------------------------------------------

  void onFrequencyChanged(dynamic frequency) {
    editingFilter.frequency = frequency;
    notifyListeners();
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
