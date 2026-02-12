import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItemWidget extends StatelessWidget {
  final String text;
  final String icon;
  final void Function()? onTap;
  final bool isSelected;

  const MenuItemWidget({super.key, required this.text, required this.icon, required this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final iconColor = isSelected ? colors.primary : colors.onSurface;
    final textColor = isSelected ? colors.primary : colors.onSurface;
    //final design = DesignSystem.of(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7.5),
          child: Container(
            decoration: BoxDecoration(
              border: isSelected ? Border(bottom: BorderSide(width: 4, color: colors.primary)) : null,
            ),
            // decoration: BoxDecoration(
            //   border: isSelected
            //   ? Border(
            //     bottom: BorderSide(
            //       width: 4.0,
            //       color: Color(0xFFFFFFFF))) : Border.all(width: 0, color: Colors.transparent),
            // ),
            child: Center(
              child: ListTile(
                title: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 25,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                      //(isSelected ? Color(0xFFFFFFFF) : Colors.black, BlendMode.srcIn),
                      //icon,
                    ),
                    SizedBox(width: 16),
                    Text(
                      text,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: textColor),
                      // TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: isSelected ? Color(0xFFFFFFFF) : Colors.black),
                    ),
                  ],
                ),
                onTap: onTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
