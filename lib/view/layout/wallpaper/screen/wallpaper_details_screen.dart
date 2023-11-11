import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../../helper/locale/app_locale_key.dart';
import '../../../../helper/networking/api_helper.dart';
import '../../../../helper/storage/hive_methods.dart';
import '../../../../helper/theme/app_colors.dart';
import '../../../../helper/theme/app_text_style.dart';
import '../../../../helper/utils/common_methods.dart';
import '../../../../model/favorite_model.dart';
import '../../../../model/wallpaper_model.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../auth/controller/auth_controller.dart';

class WallpaperDetailsArgs {
  final WallpaperModel wallpaper;
  const WallpaperDetailsArgs({required this.wallpaper});
}

class WallpaperDetailsScreen extends StatelessWidget {
  final WallpaperDetailsArgs args;
  const WallpaperDetailsScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  static const String routeName = 'WallpaperDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<FavoriteModel>('favorite').listenable(),
        builder: (context, box, widget) {
          HiveMethods.initial(context);
          FavoriteModel? favorite = box.values
              .where((element) =>
                  element.email == context.read<AuthController>().user?.email)
              .firstOrNull;
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(tr(AppLocaleKey.wallpaperDetails)),
              automaticallyImplyLeading: true,
              actions: [
                IconButton(
                  onPressed: () {
                    _download();
                  },
                  icon: const Icon(Icons.file_download_outlined),
                ),
                IconButton(
                  onPressed: () {
                    if (favorite?.favorites.contains(args.wallpaper) == true) {
                      favorite?.favorites.remove(args.wallpaper);
                      favorite?.save();
                    } else {
                      favorite?.favorites.add(args.wallpaper);
                      favorite?.save();
                    }
                  },
                  icon: favorite?.favorites.contains(args.wallpaper) == true
                      ? const Icon(
                          Icons.favorite_rounded,
                          color: Colors.redAccent,
                        )
                      : const Icon(
                          Icons.favorite_outline_rounded,
                          color: AppColor.lightTextColor,
                        ),
                ),
              ],
            ),
            body: PhotoView(
              imageProvider: NetworkImage(args.wallpaper.src?.original ?? ""),
              loadingBuilder: (context, event) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    'App Icon',
                    style: AppTextStyle.textD16B,
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> _download() async {
    CommonMethods.loading();
    final response =
        await ApiHelper.instance.download(args.wallpaper.src?.original ?? "");
    CommonMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      CommonMethods.showToast(
        message: 'Downloaded',
      );
    } else {
      CommonMethods.showToast(
        message: response.data['message'] ?? "Error",
        color: Colors.redAccent,
      );
    }
  }
}
