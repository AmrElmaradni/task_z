import 'package:flutter/material.dart';

import '../../../helper/theme/app_colors.dart';
import '../../../helper/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final double radius;
  final double? width;
  final double height;
  final TextStyle? style;
  final String? text;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Widget? child;
  final Color? color;
  final Gradient? gradient;
  final bool isLoading;
  final void Function()? onPressed;
  const CustomButton({
    super.key,
    this.radius = 10,
    this.width,
    this.height = 45,
    this.style,
    this.text,
    this.prefixIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.color,
    this.gradient,
    this.isLoading = false,
    this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColor.mainAppColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefixIcon,
                  const SizedBox(width: 5),
                  child ??
                      Flexible(
                        child: Text(
                          text ?? "",
                          textAlign: TextAlign.center,
                          style: style ?? AppTextStyle.buttonStyle,
                        ),
                      ),
                  const SizedBox(width: 5),
                  suffixIcon,
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(radius),
                onTap: onPressed,
                child: SizedBox(
                  width: width ?? double.infinity,
                  height: height,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
