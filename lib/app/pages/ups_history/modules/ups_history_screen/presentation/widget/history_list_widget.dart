import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:treina_app/modules/domain/models/history_item_model.dart';

class UpsHistoryList extends StatefulWidget {
  final List<UpsHistoryItem> historyItems;

  const UpsHistoryList({super.key, required this.historyItems});

  @override
  State<UpsHistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<UpsHistoryList> {
  Color dangerColor = const Color(0xFFBC431B);
  Color warnColor = const Color(0xFFC7AC3E);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const Key("history_list"),
      padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
      separatorBuilder: (_, __) => SizedBox(height: 24.h),
      itemCount: widget.historyItems.length,
      itemBuilder: (context, index) {
        return _buildHistoryCard(widget.historyItems[index]);
      },
    );
  }

  //----------------------------CARD HISTÓRICO----------------------------------

  Widget _buildHistoryCard(UpsHistoryItem item) {
    bool expanded = false;
    final formattedDate = DateFormat('dd/MM/yyyy - HH:mm:ss').format(item.dateTime!);

    //--------------------------------------------------------------------------
    final severities = [
      item.FrequencySeverity(),
      item.InputVoltageSeverity(),
      item.TemperatureSeverity(),
      item.PowerSeverity(),
      item.BatterySeverity(),
    ];

    final hasAlert = severities.contains(Severity.alert);
    final hasDanger = severities.contains(Severity.danger);

    //--------------------------------------------------------------------------
    return StatefulBuilder(
      builder: (context, setStateCard) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface, //const Color(0xFF2b2b2b), // teste
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3.h))],
            ),
            child: ClipRect(
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      setStateCard(() {
                        expanded = !expanded;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h, left: 8.w, right: 8.w, bottom: 13.h),
                      child: Row(
                        children: [
                          Text(
                            "Atualização em tempo real",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface, // Color(0xFFFFFFFF),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.0,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          if (hasAlert || hasDanger)
                            SvgPicture.asset(
                              hasAlert && hasDanger
                                  ? 'assets/icons/indicator_warn_error.svg'
                                  : hasDanger
                                  ? 'assets/icons/indicator_error.svg'
                                  : 'assets/icons/indicator_warn.svg',
                              width: 20.h,
                              height: 20.h,
                            ),
                          const Spacer(),
                          Icon(
                            expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Theme.of(context).colorScheme.onSurface,
                          ), //Colors.white),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    height: 1.h,
                    thickness: 1,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  ), //Colors.white.withOpacity(0.12)),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w, bottom: 8.h),
                    child: Row(
                      children: [
                        Text(
                          "Data & Hora:",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface, //Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        //---------------TEXTO COLOCADO PARA TESTE----------------
                        Text(
                          formattedDate,
                          //"11/12/2023 - 12:00",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface, //Colors.white70,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            height: 1.0,
                          ),
                        ),
                        //--------------------------------------------------------
                      ],
                    ),
                  ),

                  //--------------TESTE EXPANSÂO E TEXTOS-------------------------
                  if (expanded) ...[
                    _buildStatusRow("Frequência:", "${item.frequency} Hz", _getSeverityColor(context, item.FrequencySeverity())),
                    _buildStatusRow("Tensão de Entrada:", "${item.inputVoltage} VAC", _getSeverityColor(context, item.InputVoltageSeverity())),
                    _buildStatusRow("Tensão de saída:", "${item.outputVoltage} VAC", Theme.of(context).colorScheme.onSurface),
                    _buildStatusRow("Temperatura:", "${item.temperature} ºC", _getSeverityColor(context, item.TemperatureSeverity())),
                    _buildStatusRow("Potência de Saída:", "${item.power} %", _getSeverityColor(context, item.PowerSeverity())),
                    _buildStatusRow("Carga de bateria:", "${item.battery} %", _getSeverityColor(context, item.BatterySeverity())),
                    SizedBox(height: 12.h),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );

    //--------------------------------------------------------------------------
  }
  //----------------------------------------------------------------------------

  Widget _buildStatusRow(String title, String value, Color valueColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, //Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 4),
          Text(value, style: TextStyle(color: valueColor)), //Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------

  Color _getSeverityColor(BuildContext context, Severity severity) {
    switch (severity) {
      case Severity.alert:
        return warnColor;
      case Severity.danger:
        return dangerColor;
      case Severity.none:
        return Theme.of(context).colorScheme.onSurface;
    }
  }
}
