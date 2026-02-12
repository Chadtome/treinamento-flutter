import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionItem extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool?> onChanged;
  final Widget? trailing;

  const SelectionItem({super.key, required this.label, required this.selected, required this.onChanged, this.trailing});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20.sp,
            height: 20.sp,
            child: Transform.scale(
              scale: 1.26,
              child: Checkbox(
                value: selected,
                onChanged: onChanged, // ✅ só o checkbox é clicável
                activeColor: Theme.of(context).colorScheme.primary,
                checkColor: Colors.white, //teste
                side: BorderSide(
                  color: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  width: 1.2.sp,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.sp)),
              ),
            ),
          ),
          SizedBox(width: 7.sp),
          Flexible(
            child: Text(
              label,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ),
          if (trailing != null) ...[SizedBox(width: 8.sp), trailing!],
        ],
      ),
    );
  }
}
