import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/page/create_or_edit_task_page.dart';
//import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/scheduled_tasks_list_module.dart';
//import 'package:treina_app/app/pages/schedules_tasks/scheduled_tasks_module.dart';

class CreateOrEditTaskModule extends Module {
  CreateOrEditTaskModule() {
    print('CreateOrEditTaskModule criado');
  }
  // final ScheduledTasksModule scheduledTasksModule;
  // final ScheduledTasksListModule scheduledTasksListModule;

  //CreateOrEditTaskModule({required this.scheduledTasksModule, required this.scheduledTasksListModule});

  @override
  void routes(r) {
    print('CreateOrEditTaskModule.routes chamado');
    r.child(
      '/',
      child: (_) {
        print('CreateOrEditTaskView construído');
        return CreateOrEditTaskView();
      },
    ); //=> CreateOrEditTaskView());
  }
}
