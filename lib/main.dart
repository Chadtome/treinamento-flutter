import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:treina_app/app/app_module.dart';
//import 'package:treina_app/app/core/navigation/navigation_key.dart';
//import 'package:treina_app/app/core/navigation/navigation_key.dart';
import 'package:treina_app/app/presentation/theme/theme_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: ModularApp(module: AppModule(), child: const AppWidget()),
      //const MyApp()
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (_, themeController, __) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeController.themeMode,
              routeInformationParser: Modular.routeInformationParser,
              routerDelegate: Modular.routerDelegate,

              builder: (context, child) {
                return StyledToast(locale: const Locale('pt', 'BR'), child: child!);
              },
            );
          },
        );
      },
    );
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF06CB3F), //Color(0xFF00b26b),
    background: Color(0Xffece6F0),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    onPrimary: const Color(0xFF141414), //neutral
    secondary: Color(0xFFDCDCDC), //neutral400
    onSecondary: Color(0xFFECE6F0), //neutral100
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF06CB3F), //Color(0xFF00B26B),
    surface: Color(0xFF222222),
    background: Color(0xFF141414),
    onSurface: Colors.white,
    onPrimary: Colors.white,
    secondary: Color(0xFF888888), //neutral400
    onSecondary: Color(0xFF141414), //neutral100
  ),
);
