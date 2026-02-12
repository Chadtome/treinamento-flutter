// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/bloc/create_or_edit_task_states.dart';
// import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/bloc/create_or_edit_task_events.dart';
// import 'package:treina_app/app/pages/schedules_tasks/modules/create_or_edit_task/widgets/choose_frequency/choose_frequency_controller.dart';

// class CreateOrEditTaskBloc extends Bloc<ICreateOrEditTaskEvent, ICreateOrEditTaskState> {
//   static CreateOrEditTaskBloc get I => Modular.get<CreateOrEditTaskBloc>();

//   final ChooseFrequencyController chooseFrequencyController = ChooseFrequencyController();
//   final ChooseEventController chooseEventController = ChooseEventController();
//   final ChooseTestEventController chooseTestEventController = ChooseTestEventController();
//   final ChooseDateAndTimeController chooseDateAndTimeController = ChooseDateAndTimeController();

//   bool editMode = false;

//   //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

//   CreateOrEditTaskBloc() : super(CreateOrEditTaskFillState()) {
//     _listenBlocEvents();
//     _listenInputsUpdate();
//     _initialize();
//   }

//   //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

//   _initialize() {
//     if (Modular.get<ScheduledTasksListBloc>().editingTask != null) {
//       editMode = true;
//       Task editingTask = Modular.get<ScheduledTasksListBloc>().editingTask!;

//       if (editingTask.event != null) {
//         if (editingTask.event!.isTest) {
//           chooseTestEventController.value = editingTask.event;
//         } else {
//           chooseEventController.value = editingTask.event;
//         }
//       }

//       if (editingTask.date != null) {
//         List dateSplit = ((editingTask.date?.split("T")[0]))!.split("-");

//         // ignore: prefer_interpolation_to_compose_strings
//         String date = dateSplit[2] + "/" + dateSplit[1] + "/" + dateSplit[0];
//         String sanitizedTime = editingTask.date != null ? (editingTask.date!.split("T")[1]).replaceAll("Z", "").replaceAll(".000", "") : "";

//         chooseFrequencyController.value = editingTask.frequency;
//         chooseDateAndTimeController.dateDisplayInput.text = date;
//         chooseDateAndTimeController.timeInput.text = "${sanitizedTime.split(":")[0]}:${sanitizedTime.split(":")[1]}";
//       }
//     }
//   }

//   //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

//   _listenBlocEvents() {
//     on<ScheduleTaskEvent>((event, emit) => state.scheduleTask(event, emit));
//     on<FormUpdateEvent>((event, emit) => state.onFormUpdate(event, emit));
//   }

//   //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

//   _listenInputsUpdate() {
//     chooseFrequencyController.addListener(
//       () {
//         chooseDateAndTimeController.onChangeFrequencySelected(chooseFrequencyController.value);
//         chooseEventController.onChangeFrequencySelected(chooseFrequencyController.value);
//         chooseTestEventController.onChangeFrequencySelected(chooseFrequencyController.value);
//         add(FormUpdateEvent());
//       },
//     );

//     chooseEventController.addListener(
//       () {
//         chooseTestEventController.onSelectEvent(chooseEventController.value);
//         add(FormUpdateEvent());
//       },
//     );

//     chooseTestEventController.addListener(
//       () {
//         chooseEventController.onSelectTestEvent(chooseTestEventController.value);
//         add(FormUpdateEvent());
//       },
//     );

//     chooseTestEventController.timeInput.addListener(() => add(FormUpdateEvent()));
//     chooseDateAndTimeController.dateDisplayInput.addListener(() => add(FormUpdateEvent()));
//     chooseDateAndTimeController.timeInput.addListener(() => add(FormUpdateEvent()));
//   }
// }
