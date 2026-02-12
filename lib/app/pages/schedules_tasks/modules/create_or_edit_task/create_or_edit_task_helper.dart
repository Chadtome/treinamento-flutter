import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/models/scheduled_task_model.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/repositories/scheduled_tasks_repository.dart';

class CreateOrEditTaskHelper {
  final ScheduledTasksRepository _repository = Modular.get<ScheduledTasksRepository>();

  ScheduledTaskModel? taskBeingEdited;

  ScheduledTaskModel? get editingTask => taskBeingEdited;

  bool get isEdit => taskBeingEdited != null;

  ScheduledTaskModel? getTaskFromArgs() {
    final args = Modular.args.data;

    if (args is ScheduledTaskModel) {
      taskBeingEdited = args;
      return args;
    }

    return null;
  }

  void save({required ScheduledTaskModel newTask}) {
    if (isEdit) {
      _repository.remove(taskBeingEdited!.id);
    }
    _repository.add(newTask);
  }
}
