import 'package:flutter/material.dart';

//---------------------Dropdown personalizado-----------------------------------

class DropdownLikeInput extends StatefulWidget {
  final String hint;
  final String? value;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final bool enabled;

  const DropdownLikeInput({super.key, required this.hint, this.value, required this.options, required this.onSelected, this.enabled = true});

  @override
  State<DropdownLikeInput> createState() => DropdownLikeInputState();
}

class DropdownLikeInputState extends State<DropdownLikeInput> {
  bool isOpen = false;
  late String? selectedValue;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  //----------------------------------------------------------------------------
  @override
  void didUpdateWidget(covariant DropdownLikeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      selectedValue = widget.value;
    }
  }

  bool get hasValue => selectedValue != null && selectedValue!.isNotEmpty;

  static const double _inputHeight = 24;
  static const double _textBottomPadding = 4;
  static const double _labelDistanceFromLine = 32;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(onTap: !widget.enabled ? null : _toggleDropdown, behavior: HitTestBehavior.opaque, child: buildInput(context)),
        ),
      ],
    );
  }
  //----------------------------------------------------------------------------

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _openOverlay(); // ✅
    } else {
      _closeOverlay();
    }
  }

  //----------------------------------------------------------------------------
  void _openOverlay() {
    final overlay = Overlay.of(context);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: _closeOverlay),
            ),
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0, _labelDistanceFromLine + _inputHeight + 8),
                child: buildDropdownList(context),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);

    setState(() => isOpen = true);
  }
  //----------------------------------------------------------------------------

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isOpen = false);
  }

  //----------------------------------------------------------------------------

  Widget buildDropdownList(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 156),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: widget.options.map((option) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedValue = option;
                });
                widget.onSelected(option);
                _closeOverlay();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(widget.hint == 'Evento' ? eventFilterLabel(option) : option, style: const TextStyle(fontSize: 12)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  //----------------------------------------------------------------------------

  Widget buildInput(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // CORES
    final Color hintColor = isDark ? const Color(0xFF616161) : const Color.fromARGB(255, 162, 162, 162);

    final Color labelColor = hintColor;

    final Color textColor = colorScheme.onSurface; // bodyColor
    final Color disabledColor = theme.disabledColor;

    final Color underlineColor = isOpen ? colorScheme.primary : const Color(0xFFBCBCBC);

    return SizedBox(
      height: _labelDistanceFromLine + _inputHeight,
      child: Stack(
        children: [
          // LABEL
          if (hasValue)
            Positioned(
              bottom: _inputHeight + (_labelDistanceFromLine - _inputHeight),
              left: 0,
              child: Text(
                widget.hint,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: labelColor),
              ),
            ),

          // INPUT
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: _inputHeight,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: underlineColor)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // TEXTO
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: _textBottomPadding),
                      child: Text(
                        hasValue ? (widget.hint == 'Evento' ? eventFilterLabel(selectedValue!) : selectedValue!) : widget.hint,
                        //hasValue ? selectedValue! : widget.hint,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: !widget.enabled
                              ? disabledColor
                              : hasValue
                              ? textColor
                              : hintColor,
                        ),
                      ),
                    ),
                  ),

                  // ÍCONE
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Icon(
                      isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      size: 18,
                      color: widget.enabled
                          ? isOpen
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//---------------TROCA DO NOME NA LISTAGEM DO FILTRO----------------------------
const Map<String, String> eventLabelsForFilter = {
  'Testar bateria por 10 segundos': 'Teste bateria (10s)',
  'Testar bateria por:': 'Teste bateria (minutos)',
  'Testar bateria até autonomia baixa': 'Teste bateria (autonomia baixa)',
};

String eventFilterLabel(String event) {
  return eventLabelsForFilter[event] ?? event;
}
