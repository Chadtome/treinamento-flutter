import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treina_app/app/pages/home/presentation/widget/status_monitoring_area.dart';
import 'package:treina_app/modules/domain/models/current_status_model.dart';

void main() {
  testWidgets('StatusMonitoringArea golden test', (tester) async {
    final status = CurrentStatus(inputVoltage: 220, outputVoltage: 220, power: 50, frequency: 60, connection: 'Online', temperature: 30, battery: 80);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(body: StatusMonitoringArea(status: status)),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(find.byType(StatusMonitoringArea), matchesGoldenFile('goldens/status_monitoring_area.png'));
  });
}
