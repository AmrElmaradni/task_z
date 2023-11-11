import 'package:flutter/material.dart';

import '../../../../helper/theme/app_colors.dart';
import '../../../../model/wallpaper_model.dart';
import '../../../custom_widgets/custom_image/custom_network_image.dart';
import '../screen/wallpaper_details_screen.dart';

class WallpaperWidget extends StatelessWidget {
  final WallpaperModel wallpaper;
  const WallpaperWidget({
    super.key,
    required this.wallpaper,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          WallpaperDetailsScreen.routeName,
          arguments: WallpaperDetailsArgs(
            wallpaper: wallpaper,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.mainAppColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomNetworkImage(
          imageUrl: wallpaper.src?.medium ?? "",
          fit: BoxFit.cover,
          radius: 10,
        ),
      ),
    );
  }
}
