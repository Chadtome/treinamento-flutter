import 'package:treina_app/app/pages/schedules_tasks/domain/models/scheduled_task_model.dart';

class ScheduledTasksRepository {
  final List<ScheduledTaskModel> _tasks = [];

  List<ScheduledTaskModel> getAll() {
    return List.unmodifiable(_tasks);
  }

  void add(ScheduledTaskModel task) {
    //--------------- Não salvar a frequência "Imediatamente"---------------------
    if (task.frequency == 'Imediatamente') {
      return;
    }
    _tasks.add(task);
    //----- Manter a lista ordenada pela data mais longe ser o topo da lista -----
    _tasks.sort((a, b) => b.executionDateTime.compareTo(a.executionDateTime));
  }

  void remove(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }

  void clear() {
    _tasks.clear();
  }
}
