import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:treina_app/app/presentation/theme/widgets/box_button_widget.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Toast {
  static Future show({
    required BuildContext context,
    required ButtonKind kind,
    required String text,
    String? actionLabel,
    VoidCallback? onAction,
  }) async {
    Duration duration = const Duration(seconds: 5);
    Duration animationDuration = const Duration(milliseconds: 1500);

    Color kindColor = Colors.white;

    if (kind == ButtonKind.primary) {
      kindColor = Theme.of(context).colorScheme.primary;
    } else if (kind == ButtonKind.green) {
      kindColor = const Color(0xFF06CB3F);
    } else if (kind == ButtonKind.error) {
      kindColor = const Color(0xFFD72736);
    } else if (kind == ButtonKind.alert) {
      kindColor = const Color(0xFFEAB42A);
    }

    double toastHeight = 120.sp;
    if (text.length > 90) {
      toastHeight = 200.sp;
    }

    showToastWidget(
      SizedBox(
        height: toastHeight,
        child: Padding(
          padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: 1.sw,
                  height: 30,
                  decoration: BoxDecoration(
                    color: kindColor,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.sp), bottomRight: Radius.circular(12.sp)),
                  ),
                ),
              ),
              Positioned(
                bottom: 4.sp,
                left: 0.sp,
                right: 0.sp,
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsets.all(14.sp),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.sp)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/information.svg', color: kindColor, height: 20.sp),
                          SizedBox(width: 10.sp),
                          Flexible(
                            child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.sp),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //----------------------------------------------------
                          if (actionLabel != null)
                            //GestureDetector(
                            InkWell(
                              onTap: () {
                                ToastManager().dismissAll();
                                onAction?.call();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                                child: Text(
                                  actionLabel,
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kindColor),
                                ),
                              ),
                            ),

                          if (actionLabel != null) SizedBox(width: 16.sp),

                          GestureDetector(
                            onTap: () => ToastManager().dismissAll(),
                            child: SvgPicture.asset('assets/icons/close.svg', color: kindColor, height: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      startOffset: const Offset(0.0, -1.0),
      reverseEndOffset: const Offset(0.0, -3.0),
      duration: duration,
      animDuration: animationDuration,
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
      isIgnoring: false, // apenas para teste
    );
  }

  //-----------------------Todas funções toast estão clicáveis--------------------
  static void showSuccess({required BuildContext context, required String text}) {
    show(context: context, kind: ButtonKind.green, text: text, actionLabel: 'OK', onAction: null);
  }

  static void showError({required BuildContext context, required String text}) {
    show(context: context, kind: ButtonKind.error, text: text);
  }

  //-----------------------Alerta sem ação de desfazer----------------------------
  static void showAlert({required BuildContext context, required String text}) {
    show(context: context, kind: ButtonKind.alert, text: text);
  }

  //----------------------Alerta com ação de desfazer-----------------------------
  static void showAlertUndo({required BuildContext context, required String text, required VoidCallback onUndo}) {
    show(context: context, kind: ButtonKind.alert, text: text, actionLabel: 'Desfazer', onAction: onUndo);
  }
}
