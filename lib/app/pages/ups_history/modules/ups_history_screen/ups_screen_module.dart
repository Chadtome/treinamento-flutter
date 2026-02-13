import 'package:flutter_modular/flutter_modular.dart';
import 'package:treina_app/app/pages/ups_history/modules/ups_history_screen/presentation/history_screen_page.dart';

class UpsHistoryScreenModule extends Module {
  UpsHistoryScreenModule() {}

  @override
  void routes(r) {
    r.child('/', child: (context) => UpsHistoryScreen());
  }
}
