import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_event/choose_event_controller.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/radio_box_section_mixin.widget.dart';

class ChooseEvent extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? selectedValue;
  final bool enabled;

  const ChooseEvent({super.key, required this.selectedValue, required this.onChanged, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Text(
              'Evento',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface, letterSpacing: 0.5),
            ),
            SizedBox(height: 14.sp),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SelectionItem(
                        label: eventOptions[0],
                        selected: selectedValue == eventOptions[0],
                        onChanged: (_) => onChanged(eventOptions[0]),
                      ),
                    ),
                    SizedBox(width: 16.sp),
                    Expanded(
                      child: SelectionItem(
                        label: eventOptions[3],
                        selected: selectedValue == eventOptions[3],
                        onChanged: (_) => onChanged(eventOptions[3]),
                        trailing: Tooltip(
                          message: '',
                          child: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary, size: 20.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.sp),
                Row(
                  children: [
                    Expanded(
                      child: SelectionItem(
                        label: eventOptions[1],
                        selected: selectedValue == eventOptions[1],
                        onChanged: (_) => onChanged(eventOptions[1]),
                      ),
                    ),
                    SizedBox(width: 16.sp),
                    Expanded(
                      child: SelectionItem(
                        label: eventOptions[4],
                        selected: selectedValue == eventOptions[4],
                        onChanged: (_) => onChanged(eventOptions[4]),
                        trailing: Tooltip(
                          message: '',
                          child: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary, size: 20.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.sp),
                Row(
                  children: [
                    Expanded(
                      child: SelectionItem(
                        label: eventOptions[2],
                        selected: selectedValue == eventOptions[2],
                        onChanged: (_) => onChanged(eventOptions[2]),
                      ),
                    ),
                    SizedBox(width: 16.sp),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
