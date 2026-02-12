// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:treina_app/app/pages/schedules_tasks/domain/models/task_model.dart';
// import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/bloc/create_or_edit_task_bloc.dart';
// import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/bloc/create_or_edit_task_events.dart';

// abstract class ICreateOrEditTaskState {
//   CreateOrEditTaskBloc get bloc => Modular.get<CreateOrEditTaskBloc>();

//   Future scheduleTask(
//     ScheduleTaskEvent event,
//     Emitter<ICreateOrEditTaskState> emit,
//   ) async {}

//   Future onFormUpdate(
//     FormUpdateEvent event,
//     Emitter<ICreateOrEditTaskState> emit,
//   ) async {
//     bool validated = true;

//     ScheduledFrequency? selectedFrequency = bloc.chooseFrequencyController.value;

//     if (selectedFrequency == null || selectedFrequency == ScheduledFrequency.immediately) {
//       validated = true;
//     } else if (selectedFrequency == ScheduledFrequency.daily) {
//       if (bloc.chooseDateAndTimeController.timeInput.text.isEmpty) validated = false;
//     } else {
//       if (bloc.chooseDateAndTimeController.validateAllInputs() == false) validated = false;
//     }

//     if (bloc.chooseEventController.value == null && bloc.chooseTestEventController.value == null) {
//       validated = false;
//     }

//     if (bloc.chooseTestEventController.value == ScheduledEvent.minutesTest) {
//       if (bloc.chooseTestEventController.timeInput.text.isEmpty) {
//         validated = false;
//       }
//     }

//     if (validated == false) {
//       emit(CreateOrEditTaskFillState());
//       return;
//     }

//     emit(CreateOrEditTaskCompleteState());
//   }

//   _resetForm() {
//     bloc.chooseFrequencyController.reset();
//     bloc.chooseDateAndTimeController.reset();
//     bloc.chooseEventController.reset();
//     bloc.chooseTestEventController.reset();
//   }
// }

// class CreateOrEditTaskFillState extends ICreateOrEditTaskState {}

// class CreateOrEditTaskCompleteState extends ICreateOrEditTaskState {
//   @override
//   Future scheduleTask(
//     ScheduleTaskEvent event,
//     Emitter<ICreateOrEditTaskState> emit,
//   ) async {
//     try {
//       emit(CreateOrEditTaskProcessingState());

//       await AppController.I.showLoadModal();

//       ScheduleEvent? event;
//       if (bloc.chooseEventController.value != null) event = bloc.chooseEventController.value;
//       if (bloc.chooseTestEventController.value != null) event = bloc.chooseTestEventController.value;

//       String? minutesSTR;
//       if (bloc.chooseTestEventController.timeInput.text != "") minutesSTR = bloc.chooseTestEventController.timeInput.text.split(" ")[0];

//       String? finalDate = bloc.chooseDateAndTimeController.getDateWithTimeInISOFormat;

//       if (CreateOrEditTaskBloc.I.editMode) {
//         await Modular.get<IEditTask>().call(
//           task: Task(
//             id: ScheduledTasksListBloc.I.editingTask!.id,
//             internalId: ScheduledTasksListBloc.I.editingTask!.internalId,
//             date: finalDate,
//             minutes: minutesSTR != null ? int.parse(minutesSTR) : null,
//             frequency: bloc.chooseFrequencyController.value!,
//             event: event,
//             weekday: bloc.chooseDateAndTimeController.dateInputWeekDayFormat.value ? bloc.chooseDateAndTimeController.dateDisplayInput.text : null,
//           ),
//         );
//       } else {
//         await Modular.get<ICreateTask>().call(
//           task: Task(
//             id: null,
//             internalId: null,
//             date: finalDate,
//             minutes: minutesSTR != null ? int.parse(minutesSTR) : null,
//             frequency: bloc.chooseFrequencyController.value!,
//             event: event,
//             weekday: bloc.chooseDateAndTimeController.dateInputWeekDayFormat.value ? bloc.chooseDateAndTimeController.dateDisplayInput.text : null,
//           ),
//         );
//       }

//       Modular.get<ScheduledTasksListBloc>().add(ScheduledTasksTriggeredRefresh());

//       _resetForm();

//       emit(CreateOrEditTaskFillState());

//       await Future.delayed(const Duration(milliseconds: 150));
//       await AppController.I.hideLoadModal();

//       await Future.delayed(const Duration(milliseconds: 250));
//       Toast.show(
//         // ignore: use_build_context_synchronously
//         context: globalContext,
//         kind: ButtonKind.green,
//         text: CreateOrEditTaskBloc.I.editMode ? "Tarefa atualizada com sucesso!" : "Tarefa agendada com sucesso!",
//       );
//     } catch (e) {
//       emit(CreateOrEditTaskCompleteState());
//       await AppController.I.hideLoadModal();
//       await Future.delayed(const Duration(milliseconds: 200));

//       String errorDetails = "";
//       if (e is DioException && e.response != null && e.response?.data != null) {
//         bool isPresentable = e.response?.data["isPresentable"] ?? false;
//         if (isPresentable) errorDetails = e.response?.data["message"];
//       }

//       Toast.show(
//         // ignore: use_build_context_synchronously
//         context: globalContext,
//         kind: ButtonKind.error,
//         text: "Ocorreu um erro ao agendar a tarefa! $errorDetails",
//       );
//       rethrow;
//     }
//   }
// }

// class CreateOrEditTaskProcessingState extends ICreateOrEditTaskState {
//   @override
//   Future onFormUpdate(
//     FormUpdateEvent event,
//     Emitter<ICreateOrEditTaskState> emit,
//   ) async {}
// }
