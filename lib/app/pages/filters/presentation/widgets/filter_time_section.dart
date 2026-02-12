import 'package:flutter/material.dart';
import 'package:treina_app/app/presentation/theme/inputs/time_picker_input_widget.dart';

class TimeSection extends StatelessWidget {
  final TextEditingController startController;
  final TextEditingController endController;

  const TimeSection({super.key, required this.startController, required this.endController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimePickerInput(hintText: 'Hora inicial', controller: startController),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TimePickerInput(hintText: 'Hora final', controller: endController),
        ),
      ],
    );
  }
}
