import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomBarHistoryScreen extends StatelessWidget {
  const BottomBarHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        top: false,
        child: IntrinsicHeight(
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.only(top: 6.sp, bottom: 6.sp),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.sp), topRight: Radius.circular(12.sp)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomBarButton(iconPath: 'assets/icons/export.svg', label: "Exportar", onTap: () {}),
                _builderDivider(),
                _buildBottomBarButton(iconPath: 'assets/icons/trash_2.svg', label: "Limpar", onTap: () {}),
                _builderDivider(),
                _buildBottomBarButton(iconPath: 'assets/icons/filter.svg', label: "Filtrar", onTap: () {}),
                _builderDivider(),
                _buildBottomBarButton(iconPath: 'assets/icons/settings.svg', label: "Configurar", onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  Widget _buildBottomBarButton({required String iconPath, required String label, required Function() onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, width: 15.sp, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            SizedBox(height: 4.sp),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  Widget _builderDivider() {
    return Container(width: 1.5.sp, height: 24.sp, color: Color(0xFF163134));
  }
}
