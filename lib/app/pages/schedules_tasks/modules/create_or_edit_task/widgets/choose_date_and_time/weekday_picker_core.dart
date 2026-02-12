import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
//import 'package:ups_mobile/lib.exports.dart';

const weekdays = ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];

class WeekdayPickerCore extends StatefulWidget {
  final int? initialWeekday;
  const WeekdayPickerCore({super.key, this.initialWeekday});

  @override
  State<WeekdayPickerCore> createState() => _WeekdayPickerCoreState();
}

class _WeekdayPickerCoreState extends State<WeekdayPickerCore> {
  late int _selected;

  @override
  void initState() {
    super.initState();

    final weekday = widget.initialWeekday ?? DateTime.now().weekday;

    _selected = weekday == 7 ? 0 : weekday;
  }

  @override
  Widget build(BuildContext context) {
    //final design = DesignSystem.of(context);
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 287,
      decoration: BoxDecoration(
        color: colors.onSecondary,
        border: Border.all(width: 1, color: colors.secondary),
        borderRadius: const BorderRadius.all(Radius.circular(28.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeekdayPickerHeader(weekday: weekdays[_selected]),
          Divider(color: colors.secondary, height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekdays.asMap().entries.map((entry) {
                final index = entry.key;
                final weekday = entry.value;
                return WeekdayPickerButton(
                  weekday: weekday.substring(0, 3),
                  isSelected: index == _selected,
                  onPressed: () {
                    setState(() {
                      _selected = index;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          WeekdayPickerActions(
            onPressed: () {
              final weekday = _selected == 0 ? 7 : _selected;
              final now = DateTime.now();

              final difference = weekday - now.weekday;

              final date = DateTime.now().add(Duration(days: difference.isNegative ? difference + 7 : difference));

              Modular.to.pop({'date': date, 'weekday': weekdays[_selected]});
            },
          ),
        ],
      ),
    );
  }
}

class WeekdayPickerHeader extends StatelessWidget {
  final String weekday;

  const WeekdayPickerHeader({super.key, required this.weekday});

  @override
  Widget build(BuildContext context) {
    //final design = DesignSystem.of(context);
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecione um dia da semana',
            style: TextStyle(
              //color: design.neutral,
              //color: Theme.of(context).colorScheme.onPrimary, //neutral
              color: colors.onPrimary,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            weekday,
            style: TextStyle(
              //color: design.neutral,
              //color: Theme.of(context).colorScheme.onPrimary, //neutral
              color: colors.onPrimary, //neutral
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class WeekdayPickerButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSelected;

  final String weekday;

  const WeekdayPickerButton({super.key, required this.weekday, required this.onPressed, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    //final design = DesignSystem.of(context);
    final colors = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 32,
          width: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color: isSelected ? colors.primary : Colors.transparent,
            //color: isSelected ? design.primary : Colors.transparent,
          ),
          child: Text(
            weekday,
            style: TextStyle(
              //color: design.neutral,
              //color: Theme.of(context).colorScheme.onPrimary, //neutral
              color: colors.onPrimary, //neutral
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class WeekdayPickerActions extends StatelessWidget {
  final VoidCallback onPressed;

  const WeekdayPickerActions({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Modular.to.pop();
            },
            child: Text('Cancelar', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
          const SizedBox(width: 4),
          TextButton(
            onPressed: onPressed,
            child: Text('OK', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
