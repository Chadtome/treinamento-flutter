import 'package:flutter/material.dart';
//import 'package:flutter_modular/flutter_modular.dart';
//import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/models/scheduled_task_model.dart';
//import 'package:treina_app/app/pages/schedules_tasks/domain/repositories/scheduled_tasks_repository.dart';
//import 'package:treina_app/app/presentation/theme/widgets/toast_widget.dart';

class ScheduledTaskCardActionSlider extends StatelessWidget {
  final Widget child;
  final ScheduledTaskModel task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ScheduledTaskCardActionSlider({super.key, required this.child, required this.task, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey('${task.id}-${task.executionDateTime}'),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.35,
        children: [
          Expanded(
            child: Container(
              height: 1.sh,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(7.sp)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //---------------Botão de editar tarefas----------------------
                  _buildActionButton(
                    icon: Icons.edit_outlined,
                    color: const Color(0xff163134),
                    onTap: () {
                      Slidable.of(context)?.close();
                      onEdit();
                    },
                  ),

                  //---------------Botão de deletar tarefas---------------------
                  _buildActionButton(
                    icon: Icons.delete_outline,
                    color: const Color(0xffD72736),
                    onTap: () {
                      Slidable.of(context)?.close();
                      onDelete();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildActionButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.sp,
        height: 40.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.white, width: 1.5.sp),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
