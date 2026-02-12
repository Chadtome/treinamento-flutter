import 'package:flutter/material.dart';
import 'package:treina_app/app/pages/home/presentation/widget/drawer/drawer_component_widget.dart';
import 'package:treina_app/app/pages/home/presentation/widget/home_appbar.dart';
import 'package:treina_app/app/pages/home/presentation/widget/status_monitoring_area.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: HomeAppBar(scaffoldKey: _scaffoldKey),
      drawer: const DrawerComponent(),
      body: Stack(children: [const Positioned.fill(child: StatusMonitoringArea())]),
    );
  }
}
