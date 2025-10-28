// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomContainer extends StatelessWidget {
  double? width;
  double? height;
  double? borderRadius;
  double? spreadRadius;
  double? blurRadius;
  Color? color;
  bool isExpanded;
  Color? shadowColor;
  Color? borderColor;
  double? borderWidth;
  final VoidCallback? onTap;

  // BoxShape? shape;
  Offset? offset;
  Widget? child;
  EdgeInsets? margin;
  EdgeInsets? padding;

  CustomContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.spreadRadius,
    this.blurRadius,
    this.color,
    this.shadowColor,
    this.borderColor,
    this.borderWidth,
    this.isExpanded = true,
    this.child,
    this.margin,
    this.padding,
    this.onTap,
    this.offset,
  });

  @override
  Widget build(BuildContext context) {
    // ThemeController themeController = Get.find();
    return isExpanded
        ? InkWell(
            onTap: onTap,
            child: Container(
              margin: margin ?? EdgeInsets.all(0),
              padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                border: borderColor == null
                    ? null
                    : Border.all(color: borderColor!, width: borderWidth ?? 1),
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                // color: color ?? themeController.selectedThemeData.value.scaffoldBackgroundColor,
                // boxShadow: shadowColor == null
                //     ? null
                //     : [
                //         BoxShadow(
                //           color: shadowColor ??
                //               AppColors.appThemeColor.withOpacity(0.5),
                //           spreadRadius: spreadRadius ?? 5,
                //           blurRadius: blurRadius ?? 7,
                //           offset: offset ??
                //               const Offset(0, 3), // changes position of shadow
                //         ),
                //       ],
              ),
              child: child ?? Container(),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              height: height ?? 0,
              width: width ?? 0,
              margin: margin ?? EdgeInsets.all(0),
              padding: padding ?? EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: borderColor == null
                    ? null
                    : Border.all(color: borderColor!, width: borderWidth ?? 1),
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                color: color ?? Colors.transparent,
                // boxShadow: shadowColor == null
                //     ? null
                //     : [
                //         BoxShadow(
                //           color: shadowColor ??
                //               AppColors.appThemeColor.withOpacity(0.5),
                //           spreadRadius: spreadRadius ?? 5,
                //           blurRadius: blurRadius ?? 7,
                //           offset: offset ??
                //               const Offset(0, 3), // changes position of shadow
                //         ),
                //       ],
              ),
              child: child ?? Container(),
            ),
          );
  }
}
