import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DefaultAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);

    return AppBar(
      backgroundColor: const Color(0xFF06CB3F),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: IconButton(
          splashRadius: 30,
          icon: const Icon(Icons.arrow_back, size: 24, color: Colors.white),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.041),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/vector.svg',
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(Color(0xFF06CB3F), BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
