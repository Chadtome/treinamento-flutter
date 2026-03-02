import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/filters/controllers/filter_modal_history_controller.dart';
import 'package:treina_app/app/pages/filters/shared/widget/dropdown_like_input/dropdown_like_input.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/widget/choose_status_controller.dart';

class HistoryModalView extends StatelessWidget {
  final HistoryFilterModalController controller;
  final String? selectedStatus;
  final String? selectedActionArea;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onActionAreaChanged;

  const HistoryModalView({
    super.key,
    required this.controller,
    required this.selectedStatus,
    required this.selectedActionArea,
    required this.onStatusChanged,
    required this.onActionAreaChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isActionEnabled = selectedStatus != null && selectedStatus!.isNotEmpty;
    return Column(
      children: [
        DropdownLikeInput(
          key: const ValueKey('status_dropdown'),
          hint: 'Estado',
          value: selectedStatus,
          options: statusOption,
          onSelected: onStatusChanged,
        ),
        const SizedBox(height: 12),

        DropdownLikeInput(
          key: ValueKey('actionArea_dropdown'),
          hint: 'Area de ação do estado',
          value: selectedActionArea,
          options: controller.allParameterOptions,
          enabled: isActionEnabled,
          onSelected: onActionAreaChanged,
        ),
      ],
    );
  }
}
