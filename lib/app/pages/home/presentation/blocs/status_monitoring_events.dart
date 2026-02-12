import 'package:treina_app/modules/domain/models/current_status_model.dart';

abstract class IStatusMonitoringEvent {}

class UpdateStatus implements IStatusMonitoringEvent {
  final CurrentStatus newStatus;
  UpdateStatus({required this.newStatus});
}

class Initialize implements IStatusMonitoringEvent {}
