import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:treina_app/app/pages/home/presentation/widget/app_state.dart';
import 'package:treina_app/modules/domain/models/history_item_model.dart';

class HistoryService {
  static final HistoryService _instance = HistoryService._internal();
  factory HistoryService() => _instance;
  HistoryService._internal();

  final ValueNotifier<List<UpsHistoryItem>> history = ValueNotifier([]);

  Timer? _timer;
  //------------------------------------------------------------------------------at
  void start() async {
    await _alignToNextMinute();

    _generateSnapshot();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _generateSnapshot());
  }

  //------------------------------------------------------------------------------
  void _generateSnapshot() {
    final status = AppState.currentStatus;

    final item = UpsHistoryItem(
      inputVoltage: status.inputVoltage,
      outputVoltage: status.outputVoltage,
      power: status.power,
      frequency: status.frequency,
      connection: status.connection,
      temperature: status.temperature,
      battery: status.battery,
      dateTime: DateTime.now(),
    );

    history.value = [item, ...history.value];
  }

  //------------------------------------------------------------------------------
  Future<void> _alignToNextMinute() async {
    final now = DateTime.now();
    final secondsToNextMinute = 60 - now.second;

    await Future.delayed(Duration(seconds: secondsToNextMinute));
  }

  //------------------------------------------------------------------------------
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  //----------------------------------------------------------------------------

  void clearHistory() {
    history.value = [];
  }
}
