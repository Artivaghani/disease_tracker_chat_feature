import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/utils/app_decoration.dart';

Widget appButton(String title,
    {Gradient? gradient,
    Color? color,
    Color? textColor,
    double? width,
    double? fontSize,
    String? icon,
    TextStyle? style,
    double? height,
    Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height ?? Appdimens.dimen70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Appdimens.dimen20),
        gradient: color == null ? AppDecoration.btnGradint1() : null,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Image.asset(
                icon,
                width: Appdimens.dimen24,
              ).paddingOnly(right: Appdimens.dimenW24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: style ??
                  Get.theme.textTheme.displayMedium?.copyWith(
                      fontSize: fontSize,
                      color: textColor ?? AppColors.terneryColor),
            ),
          ],
        ),
      ),
    ),
  );
}
