import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';


// extension ThemeExtension on BuildContext {
//   AppThemeController get theme => watch<AppThemeController>();
// }

// class AppThemeController with ChangeNotifier {
//   //final ILocalStorageDriver storage = SharedPreferencesDriver();

//   final String storageTagDarkMode = "dark-mode-status";

//   bool darkThemeActive = false;

//   static AppThemeController get I {
//     if (GetIt.I.isRegistered<AppThemeController>()) {
//       return GetIt.I.get<AppThemeController>();
//     } else {
//       return AppThemeController();
//     }
//   }

//   AppThemeController() {
//     GetIt.I.registerSingleton<AppThemeController>(this);
//   }

//   Future initialize() async {
//     await _recoverDarkModeStatus();
//   }

//   Future _recoverDarkModeStatus() async {
//     bool? status = await storage.getData(key: storageTagDarkMode);

//     status ??= false;

//     changeDarkThemeActivationStatus(status);
//   }

//   changeDarkThemeActivationStatus(bool newStatus) {
//     darkThemeActive = newStatus;

//     if (darkThemeActive) {
//       //
//     } else {
//       //
//     }
//     storage.put(key: storageTagDarkMode, value: darkThemeActive);
//     notifyListeners();
//   }
// }
