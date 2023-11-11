import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'helper/routes/app_routers.dart';
import 'helper/theme/style.dart';
import 'model/favorite_model.dart';
import 'model/wallpaper_model.dart';
import 'view/layout/auth/controller/auth_controller.dart';
import 'view/layout/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteModelAdapter());
  Hive.registerAdapter(WallpaperModelAdapter());
  Hive.registerAdapter(SrcAdapter());
  Future.wait([
    EasyLocalization.ensureInitialized(),
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    Hive.openBox<FavoriteModel>('favorite'),
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      path: 'i18n',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        title: "Task",
        localizationsDelegates: [
          ...context.localizationDelegates,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: appThemeData(context),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRouters.onGenerateRoute,
        navigatorKey: AppRouters.navigatorKey,
      ),
    );
  }
}
