import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActiveFilterItem {
  final String label;
  final VoidCallback onRemove;

  ActiveFilterItem({required this.label, required this.onRemove});
}

class ActiveFiltersBar extends StatefulWidget {
  final List<ActiveFilterItem> filters;

  const ActiveFiltersBar({super.key, required this.filters});

  @override
  State<ActiveFiltersBar> createState() => _ActiveFiltersBarState();
}

class _ActiveFiltersBarState extends State<ActiveFiltersBar> {
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  static const double _scrollStep = 12;
  static const Duration _scrollInterval = Duration(milliseconds: 16);

  //----------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  //----------------------------------------------------------------------------
  void _scrollLeft() {
    if (!_scrollController.hasClients) return;

    final newOffset = (_scrollController.offset - 120).clamp(0.0, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(newOffset, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  void _scrollRight() {
    if (!_scrollController.hasClients) return;

    final newOffset = (_scrollController.offset + 120).clamp(0.0, _scrollController.position.maxScrollExtent);

    _scrollController.animateTo(newOffset, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.only(top: 16.sp, bottom: 16.sp),
      child: Row(
        children: [
          //--------------------- seta esquerda ---------------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.sp),
            child: GestureDetector(
              onTap: _scrollLeft,
              onLongPressStart: (_) => _startScroll(-1),
              onLongPressEnd: (_) => _stopScroll(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                child: SvgPicture.asset('assets/icons/arrow_left.svg', color: Theme.of(context).colorScheme.onPrimary, height: 15.sp),
              ),
            ),
          ),

          //--------------------- filtros ativos ---------------------
          Expanded(
            child: widget.filters.isEmpty
                ? Center(
                    child: Text(
                      'Nenhuma filtragem',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5.sp,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(children: widget.filters.map((filter) => _buildChip(context, filter.label, filter.onRemove)).toList()),
                  ),
          ),

          //--------------------- seta direita ---------------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.sp),
            child: GestureDetector(
              onTap: _scrollRight,
              onLongPressStart: (_) => _startScroll(1),
              onLongPressEnd: (_) => _stopScroll(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
                child: SvgPicture.asset('assets/icons/arrow_right.svg', color: Theme.of(context).colorScheme.onPrimary, height: 15.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _buildChip(BuildContext context, String text, VoidCallback onRemove) {
    return Container(
      margin: EdgeInsets.only(right: 8.sp),
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
      decoration: BoxDecoration(
        color: const Color(0xFF163134),
        borderRadius: BorderRadius.circular(32.sp),
        border: Border.all(color: const Color(0xFFFFFFFF), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 8.sp),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 14.sp, color: const Color(0xFFFFFFFF)),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  void _startScroll(double direction) {
    if (!_scrollController.hasClients) return;

    _scrollTimer?.cancel();

    _scrollTimer = Timer.periodic(_scrollInterval, (_) {
      final max = _scrollController.position.maxScrollExtent;
      final current = _scrollController.offset;

      final next = (current + direction * _scrollStep).clamp(0.0, max);

      if (next == current) {
        _stopScroll();
        return;
      }

      _scrollController.jumpTo(next);
    });
  }

  void _stopScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = null;
  }
}
