import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:treina_app/app/pages/schedules_tasks/domain/models/scheduled_task_model.dart';
//import 'package:treina_app/app/pages/schedules_tasks/domain/repositories/scheduled_tasks_repository.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/create_or_edit_task_helper.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_date_and_time/choose_data_and_time_widget.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_event/choose_event_widget.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_frequency/choose_frequency_widget.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_test_event/choose_test_event_widget.dart';
import 'package:treina_app/app/presentation/theme/widgets/box_button_widget.dart';
import 'package:treina_app/app/presentation/theme/widgets/info_bottom_sheet.dart';
import 'package:treina_app/app/presentation/theme/widgets/toast_widget.dart';
import 'package:treina_app/app/presentation/widgets/default_app_bar.dart';

class CreateOrEditTaskView extends StatefulWidget {
  const CreateOrEditTaskView({super.key});

  @override
  State<CreateOrEditTaskView> createState() => _CreateOrEditTaskViewState();
}

class _CreateOrEditTaskViewState extends State<CreateOrEditTaskView> {
  //----------------------------------------------------------------------------

  late final CreateOrEditTaskHelper _editHelper;
  bool isEditing = false;

  //----------------------------------------------------------------------------

  String? selectedFrequency; // selecionar frequencia

  String? selectedDateOrWeekday; // selecionar data ou dia da semana
  String? selectedTime; // selecionar a hora

  String? selectedEvent; // selecionar evento
  String? selectedTestEvent; // selecionar evento de teste

  String? selectedTestEventTime;

  //------lógica para o botão ser clicado somente após escolher as opções-------

  bool get hasFrequency => selectedFrequency != null;

  bool get hasValidDateTime {
    if (selectedFrequency == null) return false;

    if (selectedFrequency == 'Imediatamente') {
      return true;
    }

    if (selectedFrequency == 'Diariamente') {
      return selectedTime != null;
    }

    return selectedDateOrWeekday != null && selectedTime != null;
  }

  bool get canChooseEvent => hasFrequency && hasValidDateTime;

  bool get hasEventSelected {
    // Evento normal
    if (selectedEvent != null) return true;

    // Evento de teste
    if (selectedTestEvent != null) {
      // Caso especial: exige minutagem
      if (selectedTestEvent == 'Testar bateria por:') {
        return selectedTestEventTime != null && selectedTestEventTime!.isNotEmpty;
      }

      // Outros testes não exigem tempo
      return true;
    }

    return false;
  }

  bool get canSchedule => canChooseEvent && hasEventSelected;

  //-------------------------Tela de Agendar Tarefas----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const DefaultAppBar(title: 'Agendar Tarefa'), //_buildAppBar(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: 1.sw,
            padding: EdgeInsets.all(20.w),
            margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 18.sp),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(10.sp)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChooseFrequency(
                  selectedValue: selectedFrequency,
                  onChanged: (value) {
                    setState(() {
                      selectedFrequency = value;
                      selectedTime = null;
                      selectedDateOrWeekday = null;
                      if (value == 'Diariamente') {
                        selectedTestEvent = null;
                        selectedTestEventTime = null;
                      }
                    });
                  },
                ),
                SizedBox(height: 16.sp),
                ChooseDataAndTime(
                  frequency: selectedFrequency,
                  enabled: hasFrequency,
                  selectedDateOrWeekday: selectedDateOrWeekday,
                  selectedTime: selectedTime,
                  onDateOrWeekdayChanged: (value) {
                    setState(() {
                      selectedDateOrWeekday = value;
                    });
                  },
                  onTimeChanged: (value) {
                    setState(() {
                      selectedTime = value;
                    });
                  },
                ),
                SizedBox(height: 16.sp),
                ChooseEvent(
                  selectedValue: selectedEvent,
                  enabled: canChooseEvent,
                  onChanged: (value) {
                    setState(() {
                      selectedEvent = value;
                      selectedTestEvent = null;
                    });
                  },
                ),
                SizedBox(height: 16.sp),
                ChooseTestEvent(
                  selectedValue: selectedTestEvent,
                  enabled: canChooseEvent && selectedFrequency != 'Diariamente',
                  onChanged: (value) {
                    setState(() {
                      selectedTestEvent = value;
                      selectedEvent = null;
                      selectedTestEventTime = null;
                    });
                  },
                  onTimeChanged: (value) {
                    setState(() {
                      selectedTestEventTime = value;
                    });
                  },
                ),

                //
                SizedBox(height: 24.sp),

                _buildButtonsArea(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //----------------------Botões da tela----------------------------------------

  Widget _buildButtonsArea(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //------------------Botão de Info-----------------------------------------------
        ABoxButton.outline(
          onClick: () async {
            showInfoBottomSheet(context);
          },
          key: const Key("info_button"),
          text: "Info",
          active: true,
          kind: ButtonKind.primary,
          prefixWidget: SvgPicture.asset('assets/icons/information.svg', height: 15.sp),
        ),
        const SizedBox(width: 8),
        //------------------Botão de Cancelar-------------------------------------------
        ABoxButton.outline(
          onClick: () async {
            Modular.to.pop();
          },
          key: const Key("cancel_button"),
          text: "Cancelar",
          active: true,
          kind: ButtonKind.primary,
        ),
        const SizedBox(width: 8),

        //------------------Botão de Agendar Tarefa-----------------------------
        ABoxButton.fill(
          onClick: () async {
            final isEdit = _editHelper.isEdit;

            final task = ScheduledTaskModel(
              id: isEdit
                  ? _editHelper
                        .editingTask!
                        .id // ✅ mantém o ID
                  : DateTime.now().millisecondsSinceEpoch.toString(),
              title: 'Tarefa Agendada',
              frequency: selectedFrequency!,
              eventName:
                  selectedEvent ??
                  (selectedTestEventTime != null && selectedTestEventTime!.isNotEmpty
                      ? '$selectedTestEvent $selectedTestEventTime'
                      : selectedTestEvent) ??
                  '-',
              executionDateTime: selectedDateTime!,
              isTestEvent: selectedTestEvent != null,
              testDurationMinutes: selectedTestEvent != null ? int.tryParse(selectedTestEventTime ?? '') : null,
            );
            _editHelper.save(newTask: task);
            //Modular.to.pop(task);

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Sucesso"),
                  content: const Text("Uma tarefa foi agendada"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      child: const Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Modular.to.pop();
                        _resetForm();

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) return;
                          _onScheduleSuccess();
                        });
                      },
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
          key: const Key("schedule_button"),
          text: "Agendar Tarefa",
          active: canSchedule,
          kind: ButtonKind.primary,
        ),
      ],
    );
  }

  //------------------Lógica para resetar o formulário--------------------------

  void _resetForm() {
    setState(() {
      selectedFrequency = null;

      selectedDateOrWeekday = null;
      selectedTime = null;

      selectedEvent = null;
      selectedTestEvent = null;
    });
  }

  //--------------------Chamada do Toast de sucesso-----------------------------

  void _onScheduleSuccess() {
    Toast.showSuccess(context: context, text: "Tarefa agendada com sucesso");
  }

  //---------------Lógica para salvar nos cards---------------------------------

  DateTime? get selectedDateTime {
    //final now = DateTime.now();
    if (selectedFrequency == 'Imediatamente') {
      return DateTime.now();
    }

    if (selectedTime == null) return null;

    final timeParts = selectedTime!.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    if (selectedFrequency == 'Diariamente') {
      final now = DateTime.now();

      final todayAtTime = DateTime(now.year, now.month, now.day, hour, minute);

      if (todayAtTime.isAfter(now)) {
        return todayAtTime;
      }
      final tomorrow = now.add(const Duration(days: 1));

      return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, hour, minute);
    }

    if (selectedFrequency == 'Semanalmente' && selectedDateOrWeekday != null) {
      final now = DateTime.now();
      final targetWeekday = _weekdayFromString(selectedDateOrWeekday!);

      int daysAhead = targetWeekday - now.weekday;

      if (daysAhead == 0) {
        final scheduledToday = DateTime(now.year, now.month, now.day, hour, minute);

        if (scheduledToday.isAfter(now)) {
          return scheduledToday;
        }
        daysAhead = 7;
      }
      if (daysAhead < 0) {
        daysAhead += 7;
      }

      final nextDate = now.add(Duration(days: daysAhead));

      return DateTime(nextDate.year, nextDate.month, nextDate.day, hour, minute);
    }

    final dateString = selectedDateOrWeekday;
    if (dateString != null) {
      final dateParts = dateString.split('/');
      return DateTime(int.parse(dateParts[2]), int.parse(dateParts[1]), int.parse(dateParts[0]), hour, minute);
    }

    return null;
  }

  //--------------Transformando dia da semana em String-------------------------

  int _weekdayFromString(String value) {
    switch (value.toLowerCase()) {
      case 'segunda-feira':
        return DateTime.monday;
      case 'terça-feira':
        return DateTime.tuesday;
      case 'quarta-feira':
        return DateTime.wednesday;
      case 'quinta-feira':
        return DateTime.thursday;
      case 'sexta-feira':
        return DateTime.friday;
      case 'sábado':
        return DateTime.saturday;
      case 'domingo':
        return DateTime.sunday;
      default:
        throw Exception('Dia da semana inválido');
    }
  }

  //----------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    _editHelper = CreateOrEditTaskHelper();

    final task = _editHelper.getTaskFromArgs();

    if (task != null) {
      isEditing = true;

      selectedFrequency = task.frequency;
      _fillDateAndTimeFromTask(task);

      selectedEvent = task.isTestEvent ? null : task.eventName;
      selectedTestEvent = task.isTestEvent ? task.eventName : null;
      selectedTestEventTime = task.testDurationMinutes?.toString();
    }
  }
  //----------------------------------------------------------------------------

  void _fillDateAndTimeFromTask(ScheduledTaskModel task) {
    final dt = task.executionDateTime;

    // Hora
    selectedTime = '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

    // Frequência baseada na tarefa
    selectedFrequency = task.frequency;

    if (task.frequency == 'Diariamente') {
      selectedDateOrWeekday = null;
      return;
    }

    if (task.frequency == 'Semanalmente') {
      selectedDateOrWeekday = _weekdayToString(dt.weekday);
      return;
    }

    // Caso seja data específica
    selectedDateOrWeekday = '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  //------------------------------------------------------------------------------
  String _weekdayToString(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'segunda-feira';
      case DateTime.tuesday:
        return 'terça-feira';
      case DateTime.wednesday:
        return 'quarta-feira';
      case DateTime.thursday:
        return 'quinta-feira';
      case DateTime.friday:
        return 'sexta-feira';
      case DateTime.saturday:
        return 'sábado';
      case DateTime.sunday:
        return 'domingo';
      default:
        throw Exception('Dia inválido');
    }
  }
}
