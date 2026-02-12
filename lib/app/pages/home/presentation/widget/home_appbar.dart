import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const HomeAppBar({super.key, this.scaffoldKey});

  // @override
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => _PreferredAppBarSize(null, null);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF06CB3F),
      //toolbarHeight: 50,
      centerTitle: false,
      leading: Padding(
        padding: EdgeInsets.only(top: 2),
        child: IconButton(
          splashRadius: 28,
          icon: Icon(Icons.dehaze, size: 24, color: Color(0xFFFFFFFF)),
          onPressed: () {
            if (widget.scaffoldKey?.currentState?.isDrawerOpen == false) {
              widget.scaffoldKey?.currentState?.openDrawer();
            } else {
              widget.scaffoldKey?.currentState?.closeDrawer();
            }
          },
        ),
      ),
      leadingWidth: 52,
      titleSpacing: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset(
              'assets/images/intelbras_logo.svg',
              width: 103,
              colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn),
            ),
          ),
          Container(width: 2, height: 30, margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10), color: Color(0xFFFFFFFF)),
          Flexible(
            child: Text(
              "Gerenciamento de Nobreaks", //\n apenas para visualização
              softWrap: true,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.w800, overflow: TextOverflow.clip, height: 1.041),
            ),
          ),
          SizedBox(width: 6),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: Color(0xFFFFFFFF), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/vector.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(Color(0xFF06CB3F), BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight) : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
