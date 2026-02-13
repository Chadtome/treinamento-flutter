import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/filters/presentation/filter_modal_widget.dart';
import 'package:treina_app/app/pages/filters/presentation/widgets/active_filter_bar_scheduled_tasks.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/models/scheduled_task_model.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/repositories/scheduled_tasks_repository.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/filters/scheduled_task_filter.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/widgets/bottom_bar_scheduled_tasks_widget.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/widgets/scheduled_task_card_widget.dart';
import 'package:treina_app/app/presentation/theme/widgets/toast_widget.dart';
import 'package:treina_app/app/presentation/widgets/active_filters_bar_widget.dart';
import 'package:treina_app/app/presentation/widgets/default_app_bar.dart';

class ScheduledTasksListPage extends StatefulWidget {
  const ScheduledTasksListPage({super.key});

  @override
  State<ScheduledTasksListPage> createState() => _ScheduledTasksListPage();
}

class _ScheduledTasksListPage extends State<ScheduledTasksListPage> {
  late final ScheduledTasksRepository _repository;
  List<ScheduledTaskModel> _tasks = [];

  ScheduledTaskFilter _currentFilter = ScheduledTaskFilter();

  ScheduledTaskModel? _lastDeletedTask;
  int _listVersion = 0;

  @override
  void initState() {
    super.initState();
    _repository = Modular.get<ScheduledTasksRepository>();
    _refreshList();
    //_loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: DefaultAppBar(title: 'Lista de Tarefas Agendadas'),
      bottomNavigationBar: BottomBarScheduledTasks(
        onReturn: _refreshList,
        //onReturn: _loadTasks,
        onFilter: _openFilterModal,
      ),
      body: Column(
        children: [
          ActiveFiltersBar(
            filters: ScheduledTaskActiveFiltersBuilder.build(
              context: context,
              filter: _currentFilter,
              onRemoveEvent: _removeEventFilter,
              onRemoveFrequency: _removeFrequencyFilter,
              onRemoveDate: _removeDateFilter,
              onRemoveTime: _removeTimeFilter,
            ),
            // filter: _currentFilter,
            // onRemoveEvent: _removeEventFilter,
            // onRemoveFrequency: _removeFrequencyFilter,
            // onRemoveDate: _removeDateFilter,
            // onRemoveTime: _removeTimeFilter,
          ),
          Expanded(child: _tasks.isEmpty ? _buildEmptyState() : _buildTaskList()),
        ],
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note, size: 48, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4)),
          const SizedBox(height: 12),
          Text(
            'Nenhuma tarefa agendada',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      key: ValueKey(_listVersion),
      padding: const EdgeInsets.only(top: 16, bottom: 80),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return ScheduledTaskCard(task: task, onDelete: () => _onDeleteTask(task), onEdit: () => _onEditTask(task));
      },
    );
  }

  //------------------------------------------------------------------------------
  void _onDeleteTask(ScheduledTaskModel task) {
    _lastDeletedTask = task;

    _repository.remove(task.id);

    _refreshList();

    Toast.showAlertUndo(context: context, text: 'Tarefa deletada', onUndo: _undoDelete);
  }

  //------------------------------------------------------------------------------
  void _undoDelete() {
    if (_lastDeletedTask == null) return;

    _repository.add(_lastDeletedTask!);

    _refreshList();

    _lastDeletedTask = null;
  }

  //----------------------------------------------------------------------------

  void _onEditTask(ScheduledTaskModel task) async {
    await Modular.to.pushNamed('/scheduled_tasks/create_or_edit', arguments: task);

    _refreshList();
  }

  //----------------------------------------------------------------------------
  void _refreshList() {
    final allTasks = _repository.getAll();

    if (_currentFilter.isEmpty) {
      setState(() {
        _tasks = List.from(allTasks);
        _listVersion++;
      });
    } else {
      _applyFilter(_currentFilter);
    }
  }

  //----------------------------------------------------------------------------

  Future<void> _openFilterModal() async {
    final result = await FilterModal(initialFilter: _currentFilter).show(context: context);

    if (result == null) {
      setState(() {
        _currentFilter.clear();
        //_loadTasks();
      });
      _refreshList();
      return;
    }

    if (result is ScheduledTaskFilter) {
      setState(() {
        _currentFilter = result;
      });
      _applyFilter(result);
    }
  }

  //----------------------------------------------------------------------------

  void _applyFilter(ScheduledTaskFilter filter) {
    final allTasks = _repository.getAll();

    setState(() {
      _tasks = allTasks.where((task) {
        final taskDateTime = task.executionDateTime;

        if (filter.startDate != null) {
          final start = DateTime(filter.startDate!.year, filter.startDate!.month, filter.startDate!.day);

          if (taskDateTime.isBefore(start)) return false;
        }

        if (filter.endDate != null) {
          final end = DateTime(filter.endDate!.year, filter.endDate!.month, filter.endDate!.day, 23, 59, 59);

          if (taskDateTime.isAfter(end)) return false;
        }

        if (filter.startTime != null) {
          final startTimeMinutes = filter.startTime!.hour * 60 + filter.startTime!.minute;
          final taskMinutes = taskDateTime.hour * 60 + taskDateTime.minute;

          if (taskMinutes < startTimeMinutes) return false;
        }

        if (filter.endTime != null) {
          final endTimeMinutes = filter.endTime!.hour * 60 + filter.endTime!.minute;
          final taskMinutes = taskDateTime.hour * 60 + taskDateTime.minute;

          if (taskMinutes > endTimeMinutes) return false;
        }

        if (filter.event != null && filter.event!.isNotEmpty && task.eventName != filter.event) {
          return false;
        }

        if (filter.frequency != null && filter.frequency!.isNotEmpty && task.frequency != filter.frequency) {
          return false;
        }

        return true;
      }).toList();

      _listVersion++;
    });
  }

  //------------------REMOVER FILTRO PELO ACTIVE FILTER BAR---------------------

  void _removeEventFilter() {
    setState(() {
      _currentFilter.event = null;
      _currentFilter.frequency = null;
    });
    _applyFilter(_currentFilter);
  }

  void _removeFrequencyFilter() {
    setState(() {
      _currentFilter.frequency = null;
    });
    _applyFilter(_currentFilter);
  }

  void _removeDateFilter() {
    setState(() {
      _currentFilter.startDate = null;
      _currentFilter.endDate = null;
    });
    _applyFilter(_currentFilter);
  }

  void _removeTimeFilter() {
    setState(() {
      _currentFilter.startTime = null;
      _currentFilter.endTime = null;
    });
    _applyFilter(_currentFilter);
  }
}
