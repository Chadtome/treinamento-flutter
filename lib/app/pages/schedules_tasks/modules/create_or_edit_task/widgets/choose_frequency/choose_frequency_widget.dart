import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_frequency/choose_frequency_controller.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/radio_box_section_mixin.widget.dart';

class ChooseFrequency extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String> onChanged;
  const ChooseFrequency({super.key, required this.selectedValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Text(
          'Frequência',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface, letterSpacing: 0.5),
        ),
        SizedBox(height: 14.sp),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SelectionItem(
                    label: frequencyOptions[0],
                    selected: selectedValue == frequencyOptions[0],
                    onChanged: (_) => onChanged(frequencyOptions[0]),
                  ),
                ),
                SizedBox(width: 16.sp),
                Expanded(
                  child: SelectionItem(
                    label: frequencyOptions[3],
                    selected: selectedValue == frequencyOptions[3],
                    onChanged: (_) => onChanged(frequencyOptions[3]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.sp),
            Row(
              children: [
                Expanded(
                  child: SelectionItem(
                    label: frequencyOptions[1],
                    selected: selectedValue == frequencyOptions[1],
                    onChanged: (_) => onChanged(frequencyOptions[1]),
                  ),
                ),
                SizedBox(width: 16.sp),
                Expanded(
                  child: SelectionItem(
                    label: frequencyOptions[4],
                    selected: selectedValue == frequencyOptions[4],
                    onChanged: (_) => onChanged(frequencyOptions[4]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.sp),
            Row(
              children: [
                Expanded(
                  child: SelectionItem(
                    label: frequencyOptions[2],
                    selected: selectedValue == frequencyOptions[2],
                    onChanged: (_) => onChanged(frequencyOptions[2]),
                  ),
                ),
                SizedBox(width: 16.sp),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
