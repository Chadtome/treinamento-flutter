import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/repositories/scheduled_tasks_repository.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/create_or_edit_task_module.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/scheduled_tasks_list_module.dart';

class ScheduledTasksModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(ScheduledTasksRepository.new);
  }

  ScheduledTasksModule() {}

  @override
  void routes(r) {
    r.module('/', module: ScheduledTasksListModule());

    r.module('/create_or_edit', module: CreateOrEditTaskModule());
  }
}
