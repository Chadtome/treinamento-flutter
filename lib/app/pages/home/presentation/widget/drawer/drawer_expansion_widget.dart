import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListTileModel {
  final String title;
  final String route;
  final DrawerExpansionWidget? child;
  final List<ListTileModel>? tabList;
  final ValueChanged<String>? onTap;
  final bool isAlertDialog;
  final Widget widgetAlertDialog;
  Key? key;

  ListTileModel({
    this.key,
    required this.title,
    required this.route,
    this.child,
    this.tabList,
    this.onTap,
    this.isAlertDialog = false,
    this.widgetAlertDialog = const SizedBox.shrink(),
  });

  ListTileModel.asDropdown({
    this.key,
    required this.title,
    required this.route,
    required this.tabList,
    required this.onTap,
    this.isAlertDialog = false,
    this.widgetAlertDialog = const SizedBox.shrink(),
    child,
    int level = 1,
  }) : child = DrawerExpansionWidget(
         expansionKey: Key(title),
         title: title,
         titleRoute: route,
         level: level,
         onTap: (route) {
           if (route != '/') {
             onTap!(route);
           } else {
             null;
           }
         },
         tabList: tabList ?? [],
       );
}

class DrawerExpansionWidget extends StatefulWidget {
  //final ExpansionTileController? controller;
  final ExpansibleController? controller;
  final VoidCallback? onOpen;
  final String title;
  final String? icon;
  final bool isSelected;
  final String? titleRoute;
  final List<ListTileModel> tabList;
  final ValueChanged<String> onTap;
  final int level;
  final Key? expansionKey;

  const DrawerExpansionWidget({
    required this.title,
    required this.onTap,
    required this.tabList,
    required this.expansionKey,
    super.key,
    this.controller,
    this.isSelected = false,
    this.icon,
    this.onOpen,
    this.titleRoute,
    this.level = 1,
  });

  @override
  State<DrawerExpansionWidget> createState() => _DrawerExpansionWidgetState();
}

class _DrawerExpansionWidgetState extends State<DrawerExpansionWidget> {
  bool _isOpen = false;

  List<Widget> _buildListTiles(BuildContext context) {
    List<Widget> tiles = [];

    for (int i = 0; i < widget.tabList.length; i++) {
      tiles.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: Theme.of(context).colorScheme.surface, //Color(0xFFFFFFFF),
          child:
              widget.tabList[i].child ??
              Padding(
                padding: i >= widget.tabList.length - 1 && widget.level == 1 ? EdgeInsets.only(bottom: 12) : EdgeInsets.zero,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: widget.titleRoute == null ? 16 : 32),
                  title: Text(
                    widget.tabList[i].title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface, //Color(0xFF000000),
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  key: widget.tabList[i].key,
                  onTap: () {
                    widget.onTap(widget.tabList[i].route);
                    if (widget.tabList[i].isAlertDialog) {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        barrierDismissible: false,
                        builder: (context) => widget.tabList[i].widgetAlertDialog,
                      );
                    }
                  },
                ),
              ),
        ),
      );
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: widget.icon == null ? colorScheme.surface : Colors.transparent, //Color(0xFFFFFFFF) : Colors.transparent
      ),
      margin: widget.level == 1 ? EdgeInsets.symmetric(vertical: 7.5) : EdgeInsets.only(top: 7.5),
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            listTileTheme: const ListTileThemeData(
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              horizontalTitleGap: 0,
              contentPadding: EdgeInsets.zero,
              minTileHeight: 0,
              dense: true,
            ),
            expansionTileTheme: const ExpansionTileThemeData(tilePadding: EdgeInsets.zero, childrenPadding: EdgeInsets.zero),
          ),
          child: ListTileTheme(
            data: const ListTileThemeData(minVerticalPadding: 0),
            child: ExpansionTile(
              onExpansionChanged: (isExpanded) {
                setState(() {
                  _isOpen = isExpanded;
                });
                if (isExpanded && widget.onOpen != null) {
                  widget.onOpen!();
                }
              },
              expandedAlignment: Alignment.topCenter,
              tilePadding: const EdgeInsets.all(0),
              childrenPadding: const EdgeInsets.all(0),
              controller: widget.controller,
              showTrailingIcon: false,
              title: Container(
                height: widget.level == 1 ? 50 : null,
                decoration: BoxDecoration(
                  border: _isOpen && widget.level == 1
                      ? Border(
                          bottom: BorderSide(
                            width: 4,
                            color: colorScheme.primary, //Color(0xFFFFFFFF)
                          ),
                        )
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.icon != null
                              ? Padding(
                                  padding: EdgeInsets.only(right: 16),
                                  child: SvgPicture.asset(
                                    height: 26,
                                    colorFilter: ColorFilter.mode(
                                      (widget.isSelected || _isOpen && widget.level == 1)
                                          ? colorScheme.primary
                                          : colorScheme.onSurface, //Color(0xFFFFFFFF) : Colors.black,
                                      BlendMode.srcIn,
                                    ),
                                    widget.icon!,
                                  ),
                                )
                              : Container(),
                          _buildTitle(),
                        ],
                      ),
                      AnimatedRotation(
                        turns: _isOpen ? .5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: SvgPicture.asset(
                          height: 22,
                          'assets/icons/chevron_down.svg',
                          colorFilter: ColorFilter.mode(
                            widget.isSelected || _isOpen && widget.level == 1 ? colorScheme.primary : colorScheme.onSurface,
                            //Color(0xFFFFFFFF) : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              children: _buildListTiles(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    //final design = DesignSystem.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    Color? color = widget.isSelected || _isOpen && widget.level == 1 ? colorScheme.primary : colorScheme.onSurface;
    // Color(0xFFFFFFFF) : Colors.black;

    return GestureDetector(
      key: widget.expansionKey,
      onTap: widget.titleRoute != null
          ? () {
              widget.onTap('${widget.titleRoute}');
            }
          : null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.level == 1 ? 7.5 : 0),
        child: Text(
          widget.title,
          style: widget.level == 1
              ? TextStyle(fontSize: 16, letterSpacing: 0.5, fontWeight: FontWeight.w700, color: color)
              : TextStyle(fontSize: 12, letterSpacing: 0.5, fontWeight: FontWeight.w400, color: color),
        ),
      ),
    );
  }
}
