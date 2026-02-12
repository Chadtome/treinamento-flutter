import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TimeUnit { hour, minute, second }

class TimerPickerSettings {
  final bool enableHourSelection;
  final bool enableMinuteSelection;
  final bool enableSecondSelection;

  final int hoursRange;
  final int minutesRange;
  final int secondsRange;

  /// Cor de fundo do bottom sheet.
  final Color modalBackgroundColor;

  /// Cor de fundo do picker que é localizado dentro do bottom sheet.
  final Color pickerBackgroundColor;

  /// Cor primária, utilizada no estado ativo dos botões.
  final Color primaryColor;

  /// Cor de preenchimento do traço que é exibido centralizado na parte superior do bottom sheet.
  final Color bottomSheetTraceColor;

  /// Cor do texto do picker (cor dos números).
  final Color pickerTextColor;

  /// Cor de fundo do botão 'salvar' quando desabilitado.
  final Color disableButtonBackgroundColor;

  /// Cor de texto do botão 'salvar' quando desabilitado.
  final Color disableButtonTextColor;

  final bool startAtZero;

  const TimerPickerSettings({
    this.enableHourSelection = false,
    this.enableMinuteSelection = true,
    this.enableSecondSelection = true,
    this.hoursRange = 24,
    this.secondsRange = 60,
    this.minutesRange = 60,
    this.modalBackgroundColor = const Color(0xff222222),
    this.pickerBackgroundColor = const Color(0xff163134),
    this.primaryColor = const Color(0xff00B26B),
    this.bottomSheetTraceColor = const Color(0xffBCBCBC),
    this.pickerTextColor = Colors.white,
    this.disableButtonBackgroundColor = const Color(0xff444444),
    this.disableButtonTextColor = const Color(0xff888888),
    this.startAtZero = false,
  });
}

class TimePicker {
  TimePicker._();

  static Future<DateTime?> show(
    BuildContext context, {
    int? initialHour,
    int? initialMinute,
    int? initialSecond,
    TimerPickerSettings settings = const TimerPickerSettings(),
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return TimerPickerDialog(settings: settings, initialHour: initialHour, initialMinute: initialMinute, initialSecond: initialSecond);
      },
    );
  }
}

// ignore: must_be_immutable
class TimerPickerDialog extends StatefulWidget {
  TimerPickerDialog({super.key, required this.settings, this.initialHour, this.initialMinute, this.initialSecond});

  final TimerPickerSettings settings;
  int? initialHour;
  int? initialMinute;
  int? initialSecond;

  @override
  State<TimerPickerDialog> createState() => _TimerPickerDialogState();
}

class _TimerPickerDialogState extends State<TimerPickerDialog> {
  int _currentHourSelected = 0;
  int _currentMinuteSelected = 0;
  int _currentSecondSelected = 0;

  bool _validated = false;

  TimerPickerSettings get settings => widget.settings;

  int get _enableUnitsCounter {
    int result = 0;
    if (settings.enableHourSelection) result++;
    if (settings.enableMinuteSelection) result++;
    if (settings.enableSecondSelection) result++;
    return result;
  }

  _onSelectedHourChange(int hourSelected) {
    setState(() => _currentHourSelected = hourSelected);
    _validate();
  }

  _onSelectedMinuteChange(int minuteSelected) {
    setState(() => _currentMinuteSelected = minuteSelected);
    _validate();
  }

  _onSelectedSecondChange(int secondSelected) {
    setState(() => _currentSecondSelected = secondSelected);
    _validate();
  }

  _validate() {
    if (_currentHourSelected > 0 || _currentMinuteSelected > 0 || _currentSecondSelected > 0) {
      setState(() => _validated = true);
    } else {
      setState(() => _validated = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildDialogBody(context);
  }

  Widget _buildDialogBody(BuildContext context) {
    List<Widget> slots = [];

    if (settings.enableHourSelection) {
      slots.add(_buildPickerSlot(TimeUnit.hour, settings.hoursRange, initialValue: widget.initialHour));
    }
    if (settings.enableMinuteSelection) {
      slots.add(_buildPickerSlot(TimeUnit.minute, settings.minutesRange, initialValue: widget.initialMinute));
    }
    if (settings.enableSecondSelection) {
      slots.add(_buildPickerSlot(TimeUnit.second, settings.secondsRange, initialValue: widget.initialSecond));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            color: settings.modalBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.sp), topRight: Radius.circular(32.sp)),
          ),
          padding: EdgeInsets.only(left: 16.sp, right: 16.sp, top: 16.sp, bottom: 16.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48.w,
                height: 4.sp,
                margin: EdgeInsets.only(bottom: 16.sp),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp), color: settings.bottomSheetTraceColor),
              ),

              //- - - - - - - -
              Container(
                width: 1.sw,
                height: 171.sp,
                decoration: BoxDecoration(color: settings.pickerBackgroundColor, borderRadius: BorderRadius.circular(16.sp)),
                child: Stack(
                  children: [
                    _buildTimeDivider(),
                    //
                    Positioned.fill(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: slots),
                    ),
                  ],
                ),
              ),

              //- - - - - - - -
              _buildButtonsArea(),
            ],
          ),
        ),
      ),
    );
  }

  FixedExtentScrollController scrollControllerHour = FixedExtentScrollController();
  bool hourSlotInitialized = false;
  FixedExtentScrollController scrollControllerMinutes = FixedExtentScrollController();
  bool minuteSlotInitialized = false;
  FixedExtentScrollController scrollControllerSeconds = FixedExtentScrollController();
  bool secondSlotInitialized = false;

  Widget _buildPickerSlot(TimeUnit timeUnit, int childCount, {int? initialValue = 0}) {
    String label = "";

    late FixedExtentScrollController scrollController;

    bool? initialized;

    if (timeUnit == TimeUnit.hour) {
      label = "hor";
      scrollController = scrollControllerHour;
      initialized = hourSlotInitialized;
      hourSlotInitialized = true;
    } else if (timeUnit == TimeUnit.minute) {
      label = "min";
      scrollController = scrollControllerMinutes;
      initialized = minuteSlotInitialized;
      minuteSlotInitialized = true;
    } else if (timeUnit == TimeUnit.second) {
      label = "seg";
      scrollController = scrollControllerSeconds;
      initialized = secondSlotInitialized;
      secondSlotInitialized = true;
    }

    if (initialized == false && initialValue != null) {
      Future.delayed(const Duration(milliseconds: 50), () {
        scrollController.animateToItem(initialValue, duration: const Duration(milliseconds: 10), curve: Curves.linear);
      });
    }

    return SizedBox(
      height: 171.sp,
      width: 92.sp,
      child: Stack(
        children: [
          Positioned.fill(
            child: CupertinoPicker(
              itemExtent: 61.2.sp,
              squeeze: 1.38,
              onSelectedItemChanged: (int index) {
                if (timeUnit == TimeUnit.hour) {
                  _onSelectedHourChange(index);
                } else if (timeUnit == TimeUnit.minute) {
                  _onSelectedMinuteChange(index);
                } else if (timeUnit == TimeUnit.second) {
                  _onSelectedSecondChange(index);
                }
              },
              selectionOverlay: Container(),
              looping: true,
              useMagnifier: false,
              scrollController: scrollController,
              children: List.generate(childCount, (index) => _buildPickerItem(index, timeUnit)),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 63.sp, top: 24.sp),
              child: Text(
                label,
                style: TextStyle(fontFamily: 'MuseoSans', fontSize: 15.sp, fontWeight: FontWeight.w600, color: const Color(0xff50788A)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerItem(int index, TimeUnit timeUnit) {
    String valueText = index.toString();

    if (valueText.length == 1) {
      valueText = "0$index";
    }

    return Container(
      margin: EdgeInsets.only(bottom: 2.sp),
      width: 92.sp,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            valueText,
            style: TextStyle(fontFamily: 'MuseoSans', fontSize: 48.sp, fontWeight: FontWeight.w600, color: settings.pickerTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsArea() {
    return Padding(
      padding: EdgeInsets.only(top: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //- - - - - - - - - - - - -
          // BOTAO CANCELAR
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 11.sp, horizontal: 16.sp)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.sp))),
              side: WidgetStateProperty.all<BorderSide>(BorderSide(width: 2.0.sp, color: settings.primaryColor)),
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                return Colors.transparent;
              }),
            ),
            child: Text(
              "Cancelar",
              style: TextStyle(fontFamily: 'MuseoSans', fontSize: 12.sp, fontWeight: FontWeight.w700, color: settings.primaryColor),
            ),
          ),

          //
          SizedBox(width: 16.sp),

          //- - - - - - - - - - - - -
          // BOTAO SALVAR TEMPO
          OutlinedButton(
            onPressed: () {
              if (_validated) {
                Navigator.pop(context, DateTime(2000, 1, 1, _currentHourSelected, _currentMinuteSelected, _currentSecondSelected));
              }
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 11.sp, horizontal: 16.sp)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0.sp))),
              side: WidgetStateProperty.all<BorderSide>(BorderSide.none),
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                return _validated ? settings.primaryColor : settings.disableButtonBackgroundColor;
              }),
            ),
            child: Text(
              "Salvar Tempo",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: _validated ? Colors.white : settings.disableButtonTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDivider() {
    Widget dividerAsset = SvgPicture.asset(
      height: 24.7.sp,
      "packages/ups_flutter_plugin/lib/assets/icons/time_divider.svg",
      // package: 'ups_flutter_plugin',
    );

    List<Widget> dividersWidgets = [];

    if (_enableUnitsCounter == 1) {
      dividersWidgets.add(SizedBox(height: 24.7.sp));
    } else if (_enableUnitsCounter == 2) {
      dividersWidgets.add(dividerAsset);
    } else if (_enableUnitsCounter == 3) {
      dividersWidgets.add(dividerAsset);
      dividersWidgets.add(dividerAsset);
    }

    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: const Color(0xff50788A), width: 1.sp),
            top: BorderSide(color: const Color(0xff50788A), width: 1.sp),
          ),
        ),
        padding: EdgeInsets.only(top: 16.sp, bottom: 16.sp),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: dividersWidgets),
      ),
    );
  }
}
