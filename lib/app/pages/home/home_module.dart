import 'package:flutter/semantics.dart';
import 'package:treina_app/app/pages/home/homepage.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage(key: Key("home_screen")));
  }
}
