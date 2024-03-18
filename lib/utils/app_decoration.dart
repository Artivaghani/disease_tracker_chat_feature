import 'package:disease_tracker/config/app_config.dart';

class AppDecoration {
  static LinearGradient btnGradint1() => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1],
        colors: [
          AppColors.primaryColor,
          AppColors.blueColor,
        ],
      );

  static BoxDecoration cardDecoration(
          {Color? color,
          BorderRadiusGeometry? borderRadius,
          BoxBorder? border}) =>
      BoxDecoration(
        color: color ?? Get.theme.cardColor,
        border: border,
        borderRadius: borderRadius ?? BorderRadius.circular(Appdimens.dimen10),
      );
}
