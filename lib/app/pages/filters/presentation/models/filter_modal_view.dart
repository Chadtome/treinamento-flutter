import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/filters/controllers/filter_modal_controller.dart';
import 'package:treina_app/app/pages/filters/shared/widget/dropdown_like_input/dropdown_like_input.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_all_events_controller.dart';

class FilterModalView extends StatelessWidget {
  final FilterModalController controller;
  final String? selectedEvent;
  final String? selectedFrequency;
  final ValueChanged<String> onEventChanged;
  final ValueChanged<String> onFrequencyChanged;

  const FilterModalView({
    super.key,
    required this.controller,
    required this.selectedEvent,
    required this.selectedFrequency,
    required this.onEventChanged,
    required this.onFrequencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownLikeInput(
          key: const ValueKey('evento_dropdown'),
          hint: 'Evento',
          value: selectedEvent,
          options: allEventsOptions,
          onSelected: onEventChanged,
        ),

        const SizedBox(height: 12),

        DropdownLikeInput(
          key: const ValueKey('frequencia_dropdown'),
          hint: 'Frequência',
          value: selectedFrequency,
          options: controller.frequencyOptions,
          enabled: selectedEvent != null,
          onSelected: onFrequencyChanged,
        ),
      ],
    );
  }
}
