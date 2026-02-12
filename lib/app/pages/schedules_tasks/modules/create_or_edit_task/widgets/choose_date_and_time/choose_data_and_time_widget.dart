//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_date_and_time/weekday_picker_core.dart';

class ChooseDataAndTime extends StatefulWidget {
  final String? frequency;
  final bool enabled;
  final ValueChanged<String?>? onDateOrWeekdayChanged;
  final ValueChanged<String?>? onTimeChanged;
  final bool resetTime;
  final String? selectedTime;
  final String? selectedDateOrWeekday;

  const ChooseDataAndTime({
    super.key,
    required this.frequency,
    required this.enabled,
    this.onDateOrWeekdayChanged,
    this.onTimeChanged,
    this.resetTime = false,
    required this.selectedTime,
    required this.selectedDateOrWeekday,
  });

  @override
  State<ChooseDataAndTime> createState() => _ChooseDataAndTimeState();
}

class _ChooseDataAndTimeState extends State<ChooseDataAndTime> {
  bool dateActive = true;
  bool timeActive = true;
  bool isWeekDay = false;

  String? selectedDate;
  String? selectedTime;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.selectedDateOrWeekday;
    selectedTime = widget.selectedTime;

    _configureByFrequency(widget.frequency);
  }

  @override
  void didUpdateWidget(covariant ChooseDataAndTime oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedDateOrWeekday != oldWidget.selectedDateOrWeekday) {
      selectedDate = widget.selectedDateOrWeekday;
    }

    if (widget.selectedTime != oldWidget.selectedTime) {
      selectedTime = widget.selectedTime;
    }

    if (widget.frequency != oldWidget.frequency) {
      setState(() {
        _configureByFrequency(widget.frequency);
      });
    }
  }

  void _configureByFrequency(String? frequency) {
    if (frequency == 'Semanalmente') {
      isWeekDay = true;
      dateActive = true;
      timeActive = true;
    } else if (frequency == 'Diariamente') {
      isWeekDay = false;
      dateActive = false;
      timeActive = true;
    } else if (frequency == 'Imediatamente') {
      isWeekDay = false;
      dateActive = false;
      timeActive = false;
      selectedDate = null;
      selectedTime = null;
    } else {
      isWeekDay = false;
      dateActive = true;
      timeActive = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: Opacity(
        opacity: widget.enabled ? 1 : 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: dateActive ? 1.0 : 0.28,
              child: Text(
                'Data e Hora',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            Opacity(
              opacity: dateActive ? 1.0 : 0.28,
              child: IgnorePointer(
                ignoring: !dateActive,
                child: GestureDetector(
                  onTap: () async {
                    if (isWeekDay) {
                      final result = await showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          child: const SizedBox(width: 300, child: WeekdayPickerCore()),
                        ),
                      );

                      if (result != null) {
                        setState(() => selectedDate = result['weekday']);
                        widget.onDateOrWeekdayChanged?.call(selectedDate);
                      }
                    } else {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );

                      if (date != null) {
                        setState(() {
                          selectedDate = '${date.day}/${date.month}/${date.year}';
                        });
                        widget.onDateOrWeekdayChanged?.call(selectedDate);
                      }
                    }
                  },
                  child: _FakeInput(label: isWeekDay ? 'Selecione um dia da semana' : 'Selecione uma data', value: selectedDate),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Opacity(
              opacity: timeActive ? 1.0 : 0.28,
              child: IgnorePointer(
                ignoring: !timeActive,
                child: GestureDetector(
                  onTap: () async {
                    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                    if (time != null) {
                      setState(() {
                        selectedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                      });
                      widget.onTimeChanged?.call(selectedTime);
                    }
                  },
                  child: _FakeInput(label: 'Selecione um horário', value: selectedTime),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FakeInput extends StatelessWidget {
  final String label;
  final String? value;

  const _FakeInput({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
        const SizedBox(height: 4),
        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFBDBDBD))),
          ),
          child: Text(value ?? '', style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  //------------------------------------------------------------------------------
}
