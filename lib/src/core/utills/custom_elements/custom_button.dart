import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? buttonTextColor;
  final String buttonText;
  final double? height;
  final double? width;
  final double? borderRadius;
  final VoidCallback? onTap;
  final bool? showBorder;
  final Color? borderColor;
  final double? buttonTextSize;
  final Widget? leadingIcon;

  const CustomButton({
    super.key,
    this.buttonColor,
    required this.buttonText,
    this.buttonTextColor,
    this.buttonTextSize,
    this.height,
    this.showBorder,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.onTap,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    // ThemeController themeController = Get.find();
    return Container(
      height: height ?? 50.0, // Default height if not provided
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(
        //     color: showBorder ?? false
        //         ? borderColor ?? AppColors.appThemeColor
        //         : Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        // style: ButtonStyle(
        //     backgroundColor: WidgetStateProperty.all<Color>(
        //       buttonColor
        //           ??
        //           themeController.selectedThemeData.value.colorScheme.onPrimary,
        //     ),
        //     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(borderRadius ?? 0),
        //         ))),
        child: CustomText(
          text: buttonText,
          // textColor: buttonTextColor ??
          //     themeController.selectedThemeData.value.colorScheme.primary,
          fontSize: buttonTextSize ?? 16,
          // fontFamily: AppFonts.PoppinsRegular,
        ),
      ),
    );
  }
}
