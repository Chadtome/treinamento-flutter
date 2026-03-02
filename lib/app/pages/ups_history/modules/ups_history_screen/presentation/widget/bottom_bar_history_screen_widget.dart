import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
// import 'package:treina_app/app/pages/filters/presentation/filter_modal_history_widget.dart';
// import 'package:treina_app/app/pages/ups_history/modules/filters/ups_history_filter.dart';
import 'package:treina_app/app/pages/ups_history/modules/services/history_pdf_export_service.dart';
import 'package:treina_app/app/presentation/theme/widgets/box_button_widget.dart';
import 'package:treina_app/app/presentation/theme/widgets/toast_widget.dart';
import 'package:treina_app/modules/history_service.dart';

class BottomBarHistoryScreen extends StatelessWidget {
  final VoidCallback onFilter;
  const BottomBarHistoryScreen({super.key, required this.onFilter});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        top: false,
        child: IntrinsicHeight(
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.only(top: 6.sp, bottom: 6.sp),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.sp), topRight: Radius.circular(12.sp)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBottomBarButton(
                  iconPath: 'assets/icons/export.svg',
                  label: "Exportar",
                  onTap: () async {
                    await _handleExport(context);
                  },
                ),
                _builderDivider(),
                _buildBottomBarButton(
                  iconPath: 'assets/icons/trash_2.svg',
                  label: "Limpar",
                  onTap: () {
                    _showClearHistoryDialog(context);
                  },
                ),
                _builderDivider(),
                _buildBottomBarButton(iconPath: 'assets/icons/filter.svg', label: "Filtrar", onTap: onFilter),
                _builderDivider(),
                _buildBottomBarButton(iconPath: 'assets/icons/settings.svg', label: "Configurar", onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  Widget _buildBottomBarButton({required String iconPath, required String label, required Function() onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, width: 15.sp, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            SizedBox(height: 4.sp),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  Widget _builderDivider() {
    return Container(width: 1.5.sp, height: 24.sp, color: Color(0xFF163134));
  }

  //----------------------------------------------------------------------------
  void _showClearHistoryDialog(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.2),
          child: SizedBox(
            width: 1.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.9.sw,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12.sp)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.sp, bottom: 16.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Deseja limpar a listagem?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close, size: 24.sp, color: Color(0xFFC7AC3E)),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.sp),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.sp),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              children: [
                                const TextSpan(
                                  text:
                                      "Ao apagar, os dados serão permanentemente removidos do software conectado a este app. "
                                      "Recomendamos exportar a listagem antes de prosseguir.\n\n",
                                ),
                                const TextSpan(
                                  text: "Lembre-se: ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                const TextSpan(text: "Apenas os dados filtrados serão excluídos"),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 24.sp),
                        Padding(
                          padding: EdgeInsets.only(left: 61.sp, right: 16.sp),
                          child: Row(
                            children: [
                              ABoxButton.outline(
                                onClick: () async {
                                  Navigator.pop(dialogContext);
                                  HistoryService().clearHistory();

                                  Toast.showAlert(context: context, text: "Os dados da lista no sistema foram apagados permanentemente!");
                                },
                                text: "Apenas Limpar",
                                active: true,
                                kind: ButtonKind.alert,
                              ),
                              //),
                              SizedBox(width: 8.sp),

                              ABoxButton.fill(
                                onClick: () async {
                                  Navigator.pop(dialogContext);
                                  await _handleClearAndExport(context);
                                },
                                text: "Exporta e Limpar",
                                active: true,
                                kind: ButtonKind.alert,
                              ),
                              //),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //----------------------------------------------------------------------------
  Future<void> _handleExport(BuildContext context) async {
    final historyList = HistoryService().history.value;

    if (historyList.isEmpty) {
      Toast.showError(context: context, text: "Não há dados para exportar!");
      return;
    }
    final pdfList = historyList.map((item) {
      return PdfHistoryRecord(
        dateTime: item.dateTime != null ? DateFormat('dd/MM/yyyy HH:mm:ss').format(item.dateTime!) : "",
        inputVoltage: item.inputVoltage,
        outputVoltage: item.outputVoltage,
        frequency: item.frequency,
        temperature: item.temperature,
        power: item.power,
        battery: item.battery,
      );
    }).toList();

    await HistoryPdfExportService().export(context, pdfList);

    if (historyList.isNotEmpty) {
      Toast.showSuccess(context: context, text: 'Relatório exportado com sucesso!');
    }
  }

  //----------------------------------------------------------------------------

  Future<void> _handleClearAndExport(BuildContext context) async {
    final historyList = HistoryService().history.value;

    if (historyList.isEmpty) {
      Toast.showError(context: context, text: "Não há dados para exportar");
      return;
    }

    final pdfList = historyList.map((item) {
      return PdfHistoryRecord(
        dateTime: DateFormat('dd/MM/yyyy HH:mm:ss').format(item.dateTime!),
        inputVoltage: item.inputVoltage,
        outputVoltage: item.outputVoltage,
        frequency: item.frequency,
        temperature: item.temperature,
        power: item.power,
        battery: item.battery,
      );
    }).toList();

    final success = await HistoryPdfExportService().export(context, pdfList);

    if (success) {
      HistoryService().clearHistory();

      Toast.showAlert(context: context, text: "Relatório exportado e histórico limpo com sucesso!");
    } else {
      Toast.showError(context: context, text: "Erro ao exportar relatório.");
    }
  }
}
