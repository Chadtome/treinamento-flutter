import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:treina_app/app/presentation/theme/inputs/time_picker.widget.dart';
// import 'package:ups_flutter_plugin/ups_flutter_plugin.dart';
// import 'package:ups_mobile/lib.exports.dart';

class TimePickerInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? label;
  final bool enable;
  final TimerPickerSettings? settings;
  final bool onlyMinutes;

  const TimePickerInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.settings,
    this.label,
    this.enable = true,
    this.onlyMinutes = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enable ? 1.0 : 0.5,
      child: IgnorePointer(
        ignoring: !enable,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //- - - - - - - - - - - - - - - - - - - -
            label != null
                ? ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? Text(
                              label!,
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, letterSpacing: 0.5.sp, color: Color(0xFF888888)),
                            )
                          : Container();
                    },
                  )
                : Container(),

            //- - - - - - - - - - - - - - - - - - - -
            SizedBox(
              width: 1.sw,
              height: 28.h,
              child: TextFormField(
                readOnly: true,
                controller: controller,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onTap: () async {
                  bool startAtZero = settings?.startAtZero ?? false;

                  TimeOfDay initialTimeValues = TimeOfDay(
                    hour: controller.text.isNotEmpty
                        ? int.parse(controller.text.split(":")[0])
                        : startAtZero
                        ? 0
                        : DateTime.now().hour,
                    minute: controller.text.isNotEmpty
                        ? int.parse(controller.text.split(":")[1])
                        : startAtZero
                        ? 0
                        : DateTime.now().minute,
                  );
                  final timeSelected = await TimePicker.show(
                    context,
                    initialHour: initialTimeValues.hour,
                    initialMinute: initialTimeValues.minute,
                    settings:
                        settings ?? const TimerPickerSettings(enableHourSelection: true, enableMinuteSelection: true, enableSecondSelection: false),
                  );

                  if (timeSelected == null) return;

                  if (onlyMinutes) {
                    String formattedDate = DateFormat('mm').format(timeSelected);
                    if (formattedDate.split("").first == "0") formattedDate = formattedDate.substring(1);
                    controller.text = "$formattedDate minuto${int.parse(formattedDate) > 1 ? "s" : ""}";
                  } else {
                    String formattedDate = DateFormat('HH:mm').format(timeSelected);
                    controller.text = formattedDate;
                  }
                },
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  //fontFamily: context.design.fontFamily,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.only(bottom: 5.h),
                  suffixIconConstraints: BoxConstraints(maxHeight: 15.h),
                  suffixIcon: Icon(Icons.timer_outlined, size: 17.h, color: const Color(0xffBCBCBC)),
                  labelStyle: TextStyle(
                    fontSize: 12.sp,
                    color: const Color.fromARGB(255, 176, 176, 176),
                    fontWeight: FontWeight.w500,
                    //fontFamily: context.design.fontFamily,
                  ),
                  alignLabelWithHint: false,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xff888888),
                    fontWeight: FontWeight.w400,
                    //fontFamily: context.design.fontFamily,
                  ),
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffBCBCBC))),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
                  disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffBCBCBC))),
                  border: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffBCBCBC))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
