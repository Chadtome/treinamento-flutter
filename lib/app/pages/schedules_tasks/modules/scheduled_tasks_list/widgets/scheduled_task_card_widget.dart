import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/models/scheduled_task_model.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/widgets/scheduled_task_card_action_slider_widget.dart';
import 'package:treina_app/modules/domain/models/history_item_model.dart';

class ScheduledTaskCard extends StatelessWidget {
  final ScheduledTaskModel task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ScheduledTaskCard({super.key, required this.task, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.sp, left: 16.sp, right: 16.sp),
      child: ScheduledTaskCardActionSlider(
        task: task,
        onDelete: onDelete,
        onEdit: onEdit,
        child: Stack(
          children: [
            //--------------------------------------------------------------------
            _buildCollapsibleCard(context),
            //--------------------------------------------------------------------
            _buildFixedArea(context),
            //--------------------------------------------------------------------
          ],
        ),
      ),
    );
  }

  //----------------Cards-------------------------------------------------------

  Widget _buildCollapsibleCard(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 64.sp),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.sp)),
        child: Theme(
          data: ThemeData().copyWith(useMaterial3: false, dividerColor: Colors.transparent, splashColor: Colors.transparent),
          child: ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            minLeadingWidth: 0,
            enableFeedback: false,
            selectedColor: Colors.transparent,
            dense: true,
            child: ExpansionTile(
              dense: true,
              textColor: Theme.of(context).colorScheme.onSurface,
              collapsedTextColor: Theme.of(context).colorScheme.onSurface,
              iconColor: Theme.of(context).colorScheme.onSurface,
              collapsedIconColor: Theme.of(context).colorScheme.onSurface,
              title: Row(
                children: [
                  Text(
                    task.title, //'Tarefa Agendada',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, height: 1.041),
                  ),
                ],
              ),
              tilePadding: EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 20.sp, top: 0),
              collapsedBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              childrenPadding: EdgeInsets.only(left: 16.sp, bottom: 8.sp, top: 8.sp),
              minTileHeight: 35.sp,
              expandedAlignment: Alignment.topLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardRow(title: "Data & Hora execução:", value: _formatDateTime(task.executionDateTime), severity: Severity.none),
                SizedBox(height: 8.sp),
                _buildCardRow(title: "Frequência:", value: task.frequency, severity: Severity.none),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _buildFixedArea(BuildContext context) {
    return Positioned(
      top: 35.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.sw,
            height: 1.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12), // alterar corretamente depois
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.sp, top: 8.sp),
            child: _buildCardRow(title: "Evento:", value: task.eventName, severity: Severity.none),
          ),
        ],
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _buildCardRow({required String title, required String? value, required Severity severity}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.5, height: 1.040)),
        SizedBox(width: 4.sp),
        Text(value ?? '-', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.040)),
      ],
    );
  }

  //------------------------------------------------------------------------------
  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }
}
