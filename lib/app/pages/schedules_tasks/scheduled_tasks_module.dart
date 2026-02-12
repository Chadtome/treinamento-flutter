import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/repositories/scheduled_tasks_repository.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/create_or_edit_task_module.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/scheduled_tasks_list_module.dart';

class ScheduledTasksModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(ScheduledTasksRepository.new);
  }
  //late ScheduledTasksListModule scheduledTasksListModule;

  ScheduledTasksModule() {}
  //scheduledTasksListModule = ScheduledTasksListModule(scheduledTasksModule: this);

  @override
  void routes(r) {
    r.module('/', module: ScheduledTasksListModule()); //module: scheduledTasksListModule, duration: Duration.zero);

    r.module(
      '/create_or_edit',
      module: CreateOrEditTaskModule(),
      //CreateOrEditTaskModule(scheduledTasksModule: this, scheduledTasksListModule: scheduledTasksListModule),
      //duration: Duration.zero,
    );
  }
}
