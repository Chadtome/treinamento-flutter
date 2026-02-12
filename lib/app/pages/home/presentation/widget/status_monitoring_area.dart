import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:treina_app/app/pages/home/presentation/blocs/status_monitoring_states.dart';
import 'package:treina_app/modules/domain/models/current_status_model.dart';
import 'package:treina_app/modules/domain/models/history_item_model.dart';

class StatusMonitoringArea extends StatefulWidget {
  const StatusMonitoringArea({super.key});

  @override
  State<StatusMonitoringArea> createState() => _StatusMonitoringAreaState();
}

const Color dangerColor = Color(0xFFD72736); // variável globar para testar
const Color warningColor = Color(0xFFEAB42A); // variável globar para testar

class _StatusMonitoringAreaState extends State<StatusMonitoringArea> {
  // Color dangerColor = const Color(0xFFd72736);
  // Color warningColor = const Color(0xFFEAB42A);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LabelWidget(color: Color(0XFF06CB3F), text: 'Normal'),
                  SizedBox(width: 16),
                  LabelWidget(color: Color(0XFFEAB42A), text: 'Alerta'),
                  SizedBox(width: 16),
                  LabelWidget(color: Color(0xFFD72736), text: 'Falha'),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildContent(context),
          ],
        ),
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  final Color color;
  final String text;
  final String? value;

  const LabelWidget({super.key, this.value, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface, //Color(0xFFFFFFFF),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

//---------------------------------------------------------------------------------------------------------------------------
Widget _statusCard({
  required BuildContext context,
  required String value,
  required String title,
  required String iconPath,
  required Severity severity,
  double? customHeight,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  Color severityColor = Color(0xFF06CB3F); // Normal

  if (severity == Severity.danger) {
    severityColor = dangerColor;
  } else if (severity == Severity.alert) {
    severityColor = warningColor;
  }
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: colorScheme.surface, //Color(0XFF222222),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: severity == Severity.danger || severity == Severity.alert ? severityColor.withOpacity(0.2) : colorScheme.primary.withOpacity(0.2),
            // const Color.fromRGBO(0, 178, 107, 0.2),
            //color: severityColor.withOpacity(0.2), // testando apenas um estado
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(iconPath, height: customHeight ?? 40, colorFilter: ColorFilter.mode(severityColor, BlendMode.srcIn)),
          ),
        ),
        SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                value,
                style: TextStyle(color: severityColor, fontSize: 24, fontWeight: FontWeight.w700, height: 1.040),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurface, //Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.040,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

//---------------------------------------------------------------------------------------------------------------------------
Widget _buildContent(BuildContext context) {
  // if (state is StatusMonitoringLoadedState) {
  //   CurrentStatus status = state.currentStatus;
  final status = CurrentStatus(
    inputVoltage: 128,
    outputVoltage: 120,
    power: 70,
    frequency: 58,
    connection: 'S',
    temperature: 75,
    battery: 10,
  ); // valor para teste

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _statusCard(
        context: context,
        value: '${status.inputVoltage} VAC',
        title: 'Tensão de Entrada',
        iconPath: 'assets/icons/tensaoin.svg',
        severity: status.InputVoltageSeverity(),
      ),
      //---------------------------------------------------------
      _statusCard(
        context: context,
        value: '${status.outputVoltage} VAC',
        title: 'Tensão de Saída',
        iconPath: 'assets/icons/ups_voltage.svg',
        severity: Severity.none,
      ),

      //---------------------------------------------------------
      _statusCard(
        context: context,
        value: '${status.power} %',
        title: 'Potência de Saída',
        iconPath: 'assets/icons/potencia_saida.svg',
        severity: status.PowerSeverity(),
      ),
      //---------------------------------------------------------
      _statusCard(
        context: context,
        value: '${status.frequency} Hz',
        title: 'Frequência de Entrada',
        iconPath: 'assets/icons/frequencia_saida.svg',
        severity: status.FrequencySeverity(),
      ),
      //---------------------------------------------------------
      _statusCard(
        context: context,
        value: '${status.connectionText}',
        title: 'Conexão a Internet',
        iconPath: 'assets/icons/internet.svg',
        severity: status.ConnectionSeverity(),
      ),
      //---------------------------------------------------------
      _statusCard(
        context: context,
        value: '${status.temperature} °C',
        title: 'Temperatura',
        iconPath: 'assets/icons/temperatura.svg',
        severity: status.TemperatureSeverity(),
      ),
      //---------------------------------------------------------
      _statusCard(
        context: context,
        value: '${status.battery} %',
        title: 'Carga da Bateria',
        iconPath: 'assets/icons/battery_charge.svg',
        severity: status.BatterySeverity(),
        customHeight: 30,
      ),
    ],
  );
}
