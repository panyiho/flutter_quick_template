import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quick_template/generated/route_table.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';

import 'Initializer.dart';
import 'generated/locales.g.dart';
import 'utils/log_util.dart';

reportError(FlutterErrorDetails error) {}

void main() async {
  var onError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details);
    reportError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logE(error);
    return true;
  };
  await Initializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) => GetMaterialApp(
              getPages: RouteTable.pages,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate, //iOS
              ],
              translationsKeys: AppTranslation.translations,
              defaultTransition: Transition.cupertino,
              supportedLocales: const [
                Locale('zh', 'CN'),
                Locale('en', 'US'),
              ],
              locale: const Locale('zh', 'CN'),
              fallbackLocale: const Locale('zh', 'CN'),
              navigatorObservers: [
                defaultLifecycleObserver,
                FlutterSmartDialog.observer
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData.fallback(useMaterial3: true),
              themeMode: ThemeMode.light,
              initialRoute: RouteTable.home,
              routingCallback: (routing) {},
              builder: FlutterSmartDialog.init(),
            ));
  }
}
