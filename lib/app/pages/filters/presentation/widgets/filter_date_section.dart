import 'package:flutter/material.dart';
import 'package:treina_app/app/presentation/theme/inputs/date_picker_input_widget.dart';

class DateSection extends StatelessWidget {
  final TextEditingController startController;
  final TextEditingController endController;

  const DateSection({super.key, required this.startController, required this.endController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DatePickerInput(hintText: 'Data inicial', controller: startController),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DatePickerInput(hintText: 'Data final', controller: endController),
        ),
      ],
    );
  }
}
