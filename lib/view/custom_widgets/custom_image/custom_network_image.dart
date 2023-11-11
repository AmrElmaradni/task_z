import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../helper/theme/app_colors.dart';
import '../../../helper/theme/app_text_style.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit? fit;

  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => const CupertinoActivityIndicator(
          color: AppColor.mainAppColor,
        ),
        errorWidget: (context, url, error) => const Center(
          child: Text(
            'App Icon',
            style: AppTextStyle.textD16B,
          ),
        ),
      ),
    );
  }
}
