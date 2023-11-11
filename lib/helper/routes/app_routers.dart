import 'package:flutter/material.dart';

import '../../view/layout/auth/screen/login_screen.dart';
import '../../view/layout/auth/screen/register_screen.dart';
import '../../view/layout/splash/splash_screen.dart';
import '../../view/layout/wallpaper/screen/favorite_screen.dart';
import '../../view/layout/wallpaper/screen/home_screen.dart';
import '../../view/layout/wallpaper/screen/search_screen.dart';
import '../../view/layout/wallpaper/screen/wallpaper_details_screen.dart';

class AppRouters {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    dynamic arguments;
    if (settings.arguments != null) arguments = settings.arguments;
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case FavoriteScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const FavoriteScreen(),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case WallpaperDetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => WallpaperDetailsScreen(
            args: arguments,
          ),
        );
      default:
        return null;
    }
  }
}
