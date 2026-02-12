abstract class ICreateOrEditTaskEvent {}

class ScheduleTaskEvent extends ICreateOrEditTaskEvent {}

class FormUpdateEvent extends ICreateOrEditTaskEvent {}
