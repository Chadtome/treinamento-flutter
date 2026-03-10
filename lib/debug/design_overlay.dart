import 'package:flutter/material.dart';

class DesignOverlay extends StatefulWidget {
  final Widget child;
  final String designImage;

  const DesignOverlay({super.key, required this.child, required this.designImage});

  @override
  State<DesignOverlay> createState() => _DesignOverlayState();
}

class _DesignOverlayState extends State<DesignOverlay> {
  bool enabled = true;
  double opacity = 0.3;
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        if (enabled)
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset += details.delta;
                });
              },
              //child: IgnorePointer(
              child: Opacity(
                opacity: opacity,
                child: Image.asset(widget.designImage, width: MediaQuery.of(context).size.width, fit: BoxFit.contain),
              ),
            ),
          ),
        Positioned(right: 16, bottom: 16, child: _controlPanel()),
      ],
    );
  }

  Widget _controlPanel() {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      color: Colors.black.withOpacity(0.7),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Overlay", style: TextStyle(color: Colors.white)),
                Switch(
                  value: enabled,
                  onChanged: (v) {
                    setState(() {
                      enabled = v;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              width: 120,
              child: Slider(
                value: opacity,
                min: 0,
                max: 1,
                onChanged: (v) {
                  setState(() {
                    opacity = v;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class DesignOverlay extends StatelessWidget {
//   final Widget child;
//   final String designImage;
//   final double opacity;
//   final bool enabled;

//   const DesignOverlay({super.key, required this.child, required this.designImage, this.opacity = 0.5, this.enabled = true});

//   @override
//   Widget build(BuildContext context) {
//     if (!enabled) return child;

//     return Stack(
//       children: [
//         child,
//         IgnorePointer(
//           child: Opacity(
//             opacity: opacity,
//             child: Image.asset(designImage, width: double.infinity, fit: BoxFit.contain),
//           ),
//         ),
//       ],
//     );
//   }
// }
