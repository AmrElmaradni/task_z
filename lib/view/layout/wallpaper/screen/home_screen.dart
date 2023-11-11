import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/locale/app_locale_key.dart';
import '../../../../helper/networking/api_helper.dart';
import '../../../../helper/utils/common_methods.dart';
import '../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/screen/login_screen.dart';
import '../controller/home_controller.dart';
import '../widget/wallpaper_widget.dart';
import 'favorite_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController()
        ..initial()
        ..getWallpapers(),
      child: PageContainer(
        child: Scaffold(
          appBar: CustomAppBar(
            title: Text(tr(AppLocaleKey.home)),
            leading: IconButton(
              onPressed: () {
                CommonMethods.showLogoutDialog(
                  context,
                  onPressed: () {
                    context.read<AuthController>().logout(() {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                        (route) => false,
                      );
                    });
                  },
                );
              },
              icon: const Icon(Icons.logout_outlined),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    SearchScreen.routeName,
                  );
                },
                icon: const Icon(Icons.search_rounded),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    FavoriteScreen.routeName,
                  );
                },
                icon: const Icon(Icons.favorite_rounded),
              ),
            ],
          ),
          body: Consumer<HomeController>(
            builder: (context, homeController, _) {
              return NotificationListener(
                onNotification: (ScrollEndNotification t) =>
                    CommonMethods.endScroll(t, () {
                  if (homeController.wallpapersHasPagination) {
                    homeController.getWallpapers();
                  }
                }),
                child: Column(
                  children: [
                    Expanded(
                      child: ApiResponseWidget(
                        apiResponse: homeController.wallpapersResponse,
                        isEmpty: homeController.wallpapers.isEmpty,
                        onReload: () => homeController.getWallpapers(),
                        child: GridView.count(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(
                            homeController.wallpapers.length,
                            (index) => WallpaperWidget(
                              wallpaper: homeController.wallpapers[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (homeController.wallpapersResponse.state ==
                        ResponseState.pagination) ...{
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    },
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
