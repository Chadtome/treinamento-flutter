// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DatePickerInput extends StatelessWidget {
  final String hintText;

  final TextEditingController controller;

  DateTime? minDate;

  DateTime? maxDate;

  final String? label;

  final bool enable;

  DatePickerInput({super.key, required this.hintText, required this.controller, this.minDate, this.maxDate, this.label, this.enable = true});

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
                  DateTime? dateSelected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: minDate ?? DateTime(2024),
                    lastDate: maxDate ?? DateTime(2100),
                  );
                  if (dateSelected == null) return;
                  String formattedDate = DateFormat('dd/MM/yyyy').format(dateSelected);
                  controller.text = formattedDate;
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
                  suffixIcon: SvgPicture.asset(height: 15.h, 'assets/icons/calendar.svg'),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
