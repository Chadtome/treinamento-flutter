import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/home/home_module.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/repositories/scheduled_tasks_repository.dart';
import 'package:treina_app/app/pages/schedules_tasks/scheduled_tasks_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(ScheduledTasksRepository.new);
  }

  @override
  void routes(r) {
    r.redirect('/', to: '/home');

    r.module('/home', module: HomeModule()); //duration: Duration.zero);

    r.module('/scheduled_tasks', module: ScheduledTasksModule()); //duration: Duration.zero);
  }
}
