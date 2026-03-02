import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfHistoryRecord {
  final String dateTime;
  final double inputVoltage;
  final double outputVoltage;
  final double frequency;
  final double temperature;
  final double power;
  final double battery;

  PdfHistoryRecord({
    required this.dateTime,
    required this.inputVoltage,
    required this.outputVoltage,
    required this.frequency,
    required this.temperature,
    required this.power,
    required this.battery,
  });
}

class HistoryPdfExportService {
  Future<bool> export(BuildContext context, List<PdfHistoryRecord> items) async {
    try {
      final pdf = pw.Document();

      final now = DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(24),

          /// 🔹 Cabeçalho fixo
          header: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("RELATÓRIO DE HISTÓRICO", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.Text("Gerado em: $now", style: const pw.TextStyle(fontSize: 10)),
                pw.Divider(thickness: 1),
                pw.SizedBox(height: 8),
              ],
            );
          },

          build: (pw.Context context) {
            return [
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.green, width: 0.5),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1.5),
                  2: const pw.FlexColumnWidth(1.5),
                  3: const pw.FlexColumnWidth(1.2),
                  4: const pw.FlexColumnWidth(1.2),
                  5: const pw.FlexColumnWidth(1.2),
                  6: const pw.FlexColumnWidth(1.2),
                },
                children: [
                  /// 🔹 Cabeçalho da tabela
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.green),
                    children: _buildHeaderRow(),
                  ),

                  /// 🔹 Linhas de dados
                  ...List.generate(items.length, (index) {
                    final item = items[index];
                    final isOdd = index % 2 != 0;

                    return pw.TableRow(
                      decoration: pw.BoxDecoration(color: isOdd ? PdfColors.grey200 : PdfColors.white),
                      children: _buildDataRow(item),
                    );
                  }),
                ],
              ),
            ];
          },
        ),
      );

      /// Pasta Downloads
      final directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final nowFileName = DateFormat('dd-MM-yyyy_HH-mm-ss').format(DateTime.now());

      final file = File('${directory.path}/relatorio_$nowFileName.pdf');

      await file.writeAsBytes(await pdf.save());

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Cabeçalho da tabela
  List<pw.Widget> _buildHeaderRow() {
    final style = pw.TextStyle(color: PdfColors.white, fontSize: 9, fontWeight: pw.FontWeight.bold);

    return [
      _cell("Data & Hora", style),
      _cell("Tensão Entrada (V)", style),
      _cell("Tensão Saída (V)", style),
      _cell("Frequência (Hz)", style),
      _cell("Temperatura (°C)", style),
      _cell("Potência (%)", style),
      _cell("Bateria (%)", style),
    ];
  }

  /// Linha de dados
  List<pw.Widget> _buildDataRow(PdfHistoryRecord item) {
    final style = pw.TextStyle(fontSize: 8);

    return [
      _cell(item.dateTime, style),
      _cell(item.inputVoltage.toStringAsFixed(1), style),
      _cell(item.outputVoltage.toStringAsFixed(1), style),
      _cell(item.frequency.toStringAsFixed(1), style),
      _cell(item.temperature.toStringAsFixed(1), style),
      _cell(item.power.toStringAsFixed(0), style),
      _cell(item.battery.toStringAsFixed(0), style),
    ];
  }

  /// Célula padrão
  pw.Widget _cell(String text, pw.TextStyle style) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Center(
        child: pw.Text(text, style: style, textAlign: pw.TextAlign.center),
      ),
    );
  }
}
