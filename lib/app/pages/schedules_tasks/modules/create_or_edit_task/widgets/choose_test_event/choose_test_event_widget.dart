//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_event/choose_event_controller.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_test_event/choose_test_event_controller.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/radio_box_section_mixin.widget.dart';
import 'package:treina_app/app/presentation/theme/inputs/time_picker.widget.dart';
import 'package:treina_app/app/presentation/theme/inputs/time_picker_input_widget.dart';

class ChooseTestEvent extends StatefulWidget {
  final String? selectedValue;
  final ValueChanged<String> onChanged;
  final ValueChanged<String?> onTimeChanged;
  final bool enabled;

  const ChooseTestEvent({super.key, required this.selectedValue, required this.onChanged, required this.onTimeChanged, required this.enabled});

  @override
  State<ChooseTestEvent> createState() => _ChooseTestEventState();
}

class _ChooseTestEventState extends State<ChooseTestEvent> {
  late final TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController();

    _timeController.addListener(() {
      widget.onTimeChanged(_timeController.text.isEmpty ? null : _timeController.text);
    });
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool enableTimePicker = widget.selectedValue == testEventOptions[2];

    if (!enableTimePicker && _timeController.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _timeController.clear();
        widget.onTimeChanged(null);
      });
    }

    return IgnorePointer(
      ignoring: !widget.enabled,
      child: Opacity(
        opacity: widget.enabled ? 1 : 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Evento de teste'),
            SizedBox(height: 14.sp),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SelectionItem(
                        label: testEventOptions[0],
                        selected: widget.selectedValue == testEventOptions[0],
                        onChanged: (_) => widget.onChanged(testEventOptions[0]),
                      ),
                      SizedBox(height: 8.sp),
                      SelectionItem(
                        label: testEventOptions[1],
                        selected: widget.selectedValue == testEventOptions[1],
                        onChanged: (_) => widget.onChanged(testEventOptions[1]),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.sp),
                Expanded(
                  child: Column(
                    children: [
                      SelectionItem(
                        label: testEventOptions[2],
                        selected: widget.selectedValue == testEventOptions[2],
                        onChanged: (_) => widget.onChanged(testEventOptions[2]),
                      ),
                      TimePickerInput(
                        hintText: 'Tempo',
                        controller: _timeController,
                        enable: enableTimePicker,
                        onlyMinutes: true,
                        settings: TimerPickerSettings(
                          enableHourSelection: false,
                          enableMinuteSelection: true,
                          enableSecondSelection: false,
                          startAtZero: _timeController.text.isEmpty,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// class ChooseTestEvent extends StatelessWidget {
//   final String? selectedValue;
//   final ValueChanged<String> onChanged;
//   final ValueChanged<String?> onTimeChanged;

//   String? _selectedLabel; //add
//   final TextEditingController _timeController = TextEditingController();

//   ChooseTestEvent({super.key, required this.selectedValue, required this.onChanged, required this.onTimeChanged}) {
//     _timeController.addListener(() {
//       onTimeChanged(_timeController.text.isEmpty ? null : _timeController.text);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool enableTimePicker = selectedValue == testEventOptions[2];

//     if (!enableTimePicker) {
//       _timeController.clear();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Evento de teste',
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface, letterSpacing: 0.5),
//         ),
//         SizedBox(height: 14.sp),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   SelectionItem(
//                     label: testEventOptions[0],
//                     selected: selectedValue == testEventOptions[0],
//                     onChanged: (_) => onChanged(testEventOptions[0]),
//                   ),
//                   SizedBox(height: 8.sp),
//                   SelectionItem(
//                     label: testEventOptions[1],
//                     selected: selectedValue == testEventOptions[1],
//                     onChanged: (_) => onChanged(testEventOptions[1]),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 16.sp),
//             Expanded(
//               child: Column(
//                 children: [
//                   SelectionItem(
//                     label: testEventOptions[2],
//                     selected: selectedValue == testEventOptions[2],
//                     onChanged: (_) => onChanged(testEventOptions[2]),
//                   ),
//                   ConstrainedBox(
//                     constraints: BoxConstraints(minHeight: 38.sp),
//                     child: TimePickerInput(
//                       hintText: "Tempo",
//                       controller: _timeController,
//                       enable: enableTimePicker,
//                       onlyMinutes: true,
//                       settings: TimerPickerSettings(
//                         enableHourSelection: false,
//                         enableMinuteSelection: true,
//                         enableSecondSelection: false,
//                         startAtZero: _timeController.text.isEmpty,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

