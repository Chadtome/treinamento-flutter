import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/pages/scheduled_tasks_list_page.dart';
//import 'package:treina_app/app/pages/schedules_tasks/scheduled_tasks_module.dart';

class ScheduledTasksListModule extends Module {
  //final ScheduledTasksModule scheduledTasksModule;

  //ScheduledTasksListModule({required this.scheduledTasksModule});

  @override
  void routes(r) {
    r.child('/', child: (_) => const ScheduledTasksListPage());
    // Define routes for the ScheduledTasksListModule here
  }
}
