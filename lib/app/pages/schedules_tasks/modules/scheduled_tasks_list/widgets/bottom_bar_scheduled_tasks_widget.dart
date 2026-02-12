import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:treina_app/app/pages/filter_modal/presentation/filter_modal_widget.dart';

class BottomBarScheduledTasks extends StatelessWidget {
  final VoidCallback? onReturn;
  final VoidCallback? onFilter;

  const BottomBarScheduledTasks({super.key, required this.onReturn, required this.onFilter});

  @override
  Widget build(BuildContext context) {
    //this.context = context;
    return Container(
      color: Theme.of(context).colorScheme.background, //Theme.of(context).colorScheme.primary,
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
                _buildBottomBarButton(
                  iconPath: 'assets/icons/filter.svg',
                  label: "Filtrar",
                  onTap: () {
                    onFilter?.call();
                  },
                ),
                _builderDivider(),
                _buildBottomBarButton(
                  iconPath: 'assets/icons/plus.svg',
                  label: "Nova Tarefa",
                  onTap: () async {
                    await Modular.to.pushNamed('/scheduled_tasks/create_or_edit');
                    onReturn?.call();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builderDivider() {
    return Container(width: 1.5.sp, height: 24.sp, color: const Color(0xFF163134));
  }
}
