import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/widget/bottom_bar_history_screen_widget.dart';
import 'package:treina_app/app/presentation/widgets/default_app_bar.dart';

class UpsHistoryScreen extends StatefulWidget {
  const UpsHistoryScreen({super.key});

  @override
  State<UpsHistoryScreen> createState() => _UpsHistoryScreenState();
}

class _UpsHistoryScreenState extends State<UpsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: DefaultAppBar(title: 'Histórico do UPS'),
      bottomNavigationBar: BottomBarHistoryScreen(),
    );
  }
}
