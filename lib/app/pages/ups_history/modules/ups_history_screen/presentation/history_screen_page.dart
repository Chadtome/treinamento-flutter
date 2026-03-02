import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/filters/presentation/filter_modal_history_widget.dart';
import 'package:treina_app/app/pages/home/presentation/widget/app_state.dart';
import 'package:treina_app/app/pages/ups_history/modules/filters/ups_history_filter.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/widget/active_filters_bar_history.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/widget/bottom_bar_history_screen_widget.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/widget/history_list_widget.dart';
import 'package:treina_app/app/presentation/widgets/active_filters_bar_widget.dart';
import 'package:treina_app/app/presentation/widgets/default_app_bar.dart';
//import 'package:treina_app/modules/domain/models/current_status_model.dart';
import 'package:treina_app/modules/domain/models/history_item_model.dart';
import 'package:treina_app/modules/history_service.dart';

class UpsHistoryScreen extends StatefulWidget {
  const UpsHistoryScreen({super.key});

  @override
  State<UpsHistoryScreen> createState() => _UpsHistoryScreenState();
}

class _UpsHistoryScreenState extends State<UpsHistoryScreen> {
  HistoryFilter _currentFilter = HistoryFilter();
  //List<UpsHistoryItem> _items = [];
  //------------------------------------------------------------------------------
  final List<UpsHistoryItem> history = [];

  @override
  void initState() {
    super.initState();

    final status = AppState.currentStatus;

    history.add(
      UpsHistoryItem(
        inputVoltage: status.inputVoltage,
        outputVoltage: status.outputVoltage,
        power: status.power,
        frequency: status.frequency,
        connection: status.connection,
        temperature: status.temperature,
        battery: status.battery,
      ),
    );
  }

  //------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: DefaultAppBar(title: 'Histórico do UPS'),
      bottomNavigationBar: BottomBarHistoryScreen(onFilter: _openFilterModal),
      body: Column(
        children: [
          ActiveFiltersBar(
            filters: HistoryActiveFiltersBuilder.build(
              filter: _currentFilter,
              onRemoveStatus: _removeStatusFilter,
              onRemoveActionArea: _removeActionAreaFilter,
              onRemoveDate: _removeDateFilter,
              onRemoveTime: _removeTimeFilter,
            ),
          ),
          //filters: const []),
          Expanded(
            child: ValueListenableBuilder<List<UpsHistoryItem>>(
              valueListenable: HistoryService().history,
              builder: (context, historyItems, _) {
                final filtered = _applyFilter(historyItems);
                if (historyItems.isEmpty) {
                  return _buildEmptyState(icon: Icons.history, message: 'Nenhum histórico registrado');
                }

                if (filtered.isEmpty) {
                  return _buildEmptyState(icon: Icons.filter_alt_off, message: 'Nenhum resultado encontrado para o filtro aplicado');
                }

                return UpsHistoryList(historyItems: _applyFilter(historyItems));
              },
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------

  List<UpsHistoryItem> _applyFilter(List<UpsHistoryItem> items) {
    return items.where((item) {
      if (!_matchesStatus(item)) return false;

      if (!_matchesActionArea(item)) return false;

      if (!_matchesDate(item)) return false;

      if (!_matchesTime(item)) return false;

      return true;
    }).toList();
  }
  //----------------------------------------------------------------------------

  bool _matchesStatus(UpsHistoryItem item) {
    final status = _currentFilter.status;

    if (status == null || status.isEmpty) return true;

    final severities = [
      item.InputVoltageSeverity(),
      item.PowerSeverity(),
      item.FrequencySeverity(),
      item.TemperatureSeverity(),
      item.BatterySeverity(),
    ];

    final hasAlert = severities.contains(Severity.alert);
    final hasFailure = severities.contains(Severity.danger);

    switch (status) {
      case 'Nenhum':
        return !hasAlert && !hasFailure;

      case 'Alerta':
        return hasAlert;

      case 'Falha':
        return hasFailure;

      default:
        return true;
    }
  }

  //----------------------------------------------------------------------------

  bool _matchesActionArea(UpsHistoryItem item) {
    final area = _currentFilter.actionArea;

    if (area == null || area.isEmpty) return true;

    Severity severity;

    switch (area) {
      case 'Tensão de Entrada':
        severity = item.InputVoltageSeverity();
        break;

      case 'Potência':
        severity = item.PowerSeverity();
        break;

      case 'Frequência':
        severity = item.FrequencySeverity();
        break;

      case 'Temperatura':
        severity = item.TemperatureSeverity();
        break;

      case 'Bateria':
        severity = item.BatterySeverity();
        break;

      default:
        return true;
    }

    final status = _currentFilter.status;

    if (status == null || status.isEmpty) {
      return severity != Severity.none;
    }

    switch (status) {
      case 'Nenhum':
        return severity == Severity.none;

      case 'Alerta':
        return severity == Severity.alert;

      case 'Falha':
        return severity == Severity.danger;

      default:
        return true;
    }
  }

  //----------------------------------------------------------------------------

  bool _matchesDate(UpsHistoryItem item) {
    final start = _currentFilter.startDate;
    final end = _currentFilter.endDate;

    if (item.dateTime == null) return true;

    if (start != null) {
      final startDate = DateTime(start.year, start.month, start.day);
      if (item.dateTime!.isBefore(startDate)) return false;
    }

    if (end != null) {
      final endDate = DateTime(end.year, end.month, end.day, 23, 59, 59);
      if (item.dateTime!.isAfter(endDate)) return false;
    }

    return true;
  }

  //------------------------------------------------------------------------------

  bool _matchesTime(UpsHistoryItem item) {
    final startTime = _currentFilter.startTime;
    final endTime = _currentFilter.endTime;

    if (item.dateTime == null) return true;

    final itemMinutes = item.dateTime!.hour * 60 + item.dateTime!.minute;

    if (startTime != null) {
      final startMinutes = startTime.hour * 60 + startTime.minute;
      if (itemMinutes < startMinutes) return false;
    }

    if (endTime != null) {
      final endMinutes = endTime.hour * 60 + endTime.minute;
      if (itemMinutes > endMinutes) return false;
    }

    return true;
  }

  //----------------------------------------------------------------------------

  Future<void> _openFilterModal() async {
    final result = await HistoryFilterModal(initialFilter: _currentFilter).show(context: context);

    if (result == null) {
      setState(() {
        _currentFilter = HistoryFilter();
      });
      return;
    }

    if (result is HistoryFilter) {
      setState(() {
        _currentFilter = result;
      });
    }
  }

  //---------------------REMOVER PELO ACTIVE FILTER BAR-------------------------

  void _removeStatusFilter() {
    setState(() {
      _currentFilter.status = null;
      _currentFilter.actionArea = null;
    });
  }

  void _removeActionAreaFilter() {
    setState(() {
      _currentFilter.actionArea = null;
    });
  }

  void _removeDateFilter() {
    setState(() {
      _currentFilter.startDate = null;
      _currentFilter.endDate = null;
    });
  }

  void _removeTimeFilter() {
    setState(() {
      _currentFilter.startTime = null;
      _currentFilter.endTime = null;
    });
  }

  //----------------------------------------------------------------------------

  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4)),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
