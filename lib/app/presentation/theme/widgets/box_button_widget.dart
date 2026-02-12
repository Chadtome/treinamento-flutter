// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:ups_mobile/lib.exports.dart';

enum ButtonType { fill, outline }

enum ButtonKind { primary, green, error, alert }

class ABoxButton extends StatelessWidget {
  final Future Function() onClick;

  final String text;

  final bool active;

  late final ButtonType buttonType;

  final ButtonKind kind;

  late BuildContext context;

  final Widget? prefixWidget;

  Color get _kindColor {
    if (kind == ButtonKind.primary) {
      return Theme.of(context).colorScheme.primary;
      //return DesignSystem.of(context).primary;
    } else if (kind == ButtonKind.green) {
      return const Color(0xff06CB3F);
    } else if (kind == ButtonKind.error) {
      return const Color(0xffD72736);
    } else if (kind == ButtonKind.alert) {
      return const Color(0xffEAB42A);
    }
    return Theme.of(context).colorScheme.primary;
    //return DesignSystem.of(context).primary;
  }

  ABoxButton.fill({super.key, required this.onClick, required this.text, required this.active, required this.kind, this.prefixWidget}) {
    buttonType = ButtonType.fill;
  }

  ABoxButton.outline({super.key, required this.onClick, required this.text, required this.active, required this.kind, this.prefixWidget}) {
    buttonType = ButtonType.outline;
  }

  Color _generateBackgroundColor(BuildContext context) {
    if (buttonType == ButtonType.outline) {
      return Colors.transparent;
    } else if (buttonType == ButtonType.fill) {
      if (active) {
        return _kindColor;
      } else {
        return const Color(0xff444444);
      }
    }
    return Colors.transparent;
  }

  Color _generateTextColor(BuildContext context) {
    if (buttonType == ButtonType.outline) {
      if (active) {
        return _kindColor;
      } else {
        return Colors.grey[300]!;
      }
    } else if (buttonType == ButtonType.fill) {
      if (active) {
        return Colors.white;
      } else {
        return const Color(0xff888888);
      }
    } else {
      return Colors.white;
    }
  }

  MaterialStateProperty<BorderSide?>? _generateBorder(BuildContext context) {
    if (buttonType == ButtonType.outline) {
      return MaterialStateProperty.all<BorderSide>(BorderSide(color: active ? _kindColor : Colors.grey[300]!, width: 2.sp));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.only(top: 11.sp, bottom: 11.sp, left: 16.sp, right: 16.sp)),
        // visualDensity: VisualDensity.compact,
        minimumSize: MaterialStateProperty.all(const Size(0, 0)),
        visualDensity: VisualDensity.standard,
        backgroundColor: MaterialStateProperty.all(_generateBackgroundColor(context)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),
        side: _generateBorder(context),
      ),
      onPressed: active ? onClick : () {},
      child: Row(
        children: [
          prefixWidget != null
              ? Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: prefixWidget,
                )
              : const SizedBox.shrink(),
          Text(
            text,
            style: TextStyle(color: _generateTextColor(context), fontSize: 12.sp, fontFamily: 'MuseoSans', height: 1.2, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
