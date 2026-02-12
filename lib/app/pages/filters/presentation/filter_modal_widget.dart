import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:treina_app/app/pages/filters/controllers/filter_modal_controller.dart';
import 'package:treina_app/app/pages/filters/presentation/models/filter_modal_view.dart';
import 'package:treina_app/app/pages/filters/presentation/widgets/filter_date_section.dart';
import 'package:treina_app/app/pages/filters/presentation/widgets/filter_time_section.dart';
import 'package:treina_app/app/pages/schedules_tasks/modules/scheduled_tasks_list/filters/scheduled_task_filter.dart';
import 'package:treina_app/app/presentation/theme/widgets/box_button_widget.dart';

class FilterModal extends StatefulWidget {
  final ScheduledTaskFilter initialFilter;

  const FilterModal({super.key, required this.initialFilter});

  @override
  State<FilterModal> createState() => _FilterModalState();

  Future show({required BuildContext context}) async {
    return await showDialog(barrierDismissible: true, context: context, builder: (_) => this);
  }
}

class _FilterModalState extends State<FilterModal> {
  late BuildContext context;

  late FilterModalController controller;

  //----------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    controller = FilterModalController(initialFilter: widget.initialFilter);
  }

  //----------------------------------------------------------------------------

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      backgroundColor: Colors.black.withOpacity(0.2),
      key: const Key('filter_modal'),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              //await widget.onCancel();
              Navigator.of(context).pop(null);
            },
            child: Container(width: double.infinity, height: double.infinity, color: Colors.transparent),
          ),
          _buildContent(),
        ],
      ),
    );
  }

  //------------------------------------------------------------------------------

  Widget _buildContent() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 0.9.sw,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(16.sp)),
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filtragem',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5.sp,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            //await widget.onCancel();
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, size: 22.sp, color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  //------------------------------------------------------------
                  // FILTRO DE DATAS
                  SizedBox(height: 32.sp),

                  DateSection(startController: controller.startDateController, endController: controller.endDateController),
                  //------------------------------------------------------------
                  // FILTRO DE HORÁRIOS
                  SizedBox(height: 32.sp),

                  TimeSection(startController: controller.startTimeController, endController: controller.endTimeController),

                  //------------------------------------------------------------
                  // FILTRO DE DROPDOWNS
                  SizedBox(height: 32.sp),

                  AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) {
                      return FilterModalView(
                        selectedEvent: controller.editingFilter.event,
                        selectedFrequency: controller.editingFilter.frequency,
                        onEventChanged: controller.onEventChanged,
                        onFrequencyChanged: controller.onFrequencyChanged,
                        controller: controller,
                      );
                    },
                  ),
                  //------------------------------------------------------------
                  // BOTOES DE AÇÃO
                  SizedBox(height: 32.sp),
                  //----------------------Botão Cancelar------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ABoxButton.outline(
                        onClick: () async {
                          //await widget.onCancel();
                          Navigator.of(context).pop(null);
                        },
                        key: const Key("filter_modal_cancel_button"),
                        text: "Cancelar",
                        active: true,
                        kind: ButtonKind.primary,
                      ),

                      //----------------------Botão Limpar Filtro---------------
                      Row(
                        children: [
                          ABoxButton.outline(
                            onClick: () async {
                              controller.clear();
                              //widget.onTapClear();
                              Navigator.of(context).pop(null);
                            },
                            text: "Limpar Filtro",
                            active: true,
                            kind: ButtonKind.primary,
                          ),
                          //-------------------Botão Filtrar--------------------
                          SizedBox(width: 10.sp),
                          ABoxButton.fill(
                            key: const Key("filter_modal_filter_button"),
                            onClick: () async {
                              Navigator.of(context).pop(controller.editingFilter);
                            },
                            text: "Filtrar",
                            active: true,
                            kind: ButtonKind.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
