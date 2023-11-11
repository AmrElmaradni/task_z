import 'package:flutter/material.dart';

import '../../../helper/theme/app_colors.dart';

class CustomAppBar extends PreferredSize {
  final double height;
  final double radius;
  final double elevation;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final Color? appBarColor;
  final Color? shadowColor;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final double? leadingWidth;

  CustomAppBar({
    Key? key,
    this.height = kToolbarHeight,
    this.radius = 0,
    this.elevation = 0,
    this.leading,
    this.actions,
    this.title,
    this.appBarColor,
    this.centerTitle,
    this.bottom,
    this.leadingWidth,
    this.shadowColor,
    this.automaticallyImplyLeading = false,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(height),
          child: AppBar(
            elevation: elevation,
            backgroundColor: appBarColor ?? AppColor.scaffoldColor,
            toolbarHeight: height,
            automaticallyImplyLeading: automaticallyImplyLeading,
            shadowColor: shadowColor,
            centerTitle: centerTitle,
            title: title,
            leading: leading,
            actions: actions,
            leadingWidth: leadingWidth,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(radius),
              ),
            ),
            bottom: bottom,
            foregroundColor: AppColor.appBarTextColor,
          ),
        );
}
