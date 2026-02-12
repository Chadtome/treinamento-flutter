import 'package:treina_app/app/pages/home/homepage.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  void routes(r) {
    r.child('/', child: (context) => HomePage());
  }
}
