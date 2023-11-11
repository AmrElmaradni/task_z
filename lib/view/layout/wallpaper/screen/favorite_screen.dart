import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../helper/locale/app_locale_key.dart';
import '../../../../model/favorite_model.dart';
import '../../../../model/wallpaper_model.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../../auth/controller/auth_controller.dart';
import '../widget/wallpaper_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const String routeName = 'FavoriteScreen';

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(tr(AppLocaleKey.favorites)),
          automaticallyImplyLeading: true,
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box<FavoriteModel>('favorite').listenable(),
            builder: (context, box, widget) {
              List<WallpaperModel> wallpapers = box.values
                      .where((element) =>
                          element.email ==
                          context.read<AuthController>().user?.email)
                      .firstOrNull
                      ?.favorites ??
                  [];
              return GridView.count(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                  wallpapers.length,
                  (index) => WallpaperWidget(
                    wallpaper: wallpapers[index],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
