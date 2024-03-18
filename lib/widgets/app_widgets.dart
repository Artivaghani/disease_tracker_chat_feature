import 'package:cached_network_image/cached_network_image.dart';
import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/utils/app_decoration.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AppWidgets {
  static Widget getLoadingView() => Center(
          child: SpinKitThreeBounce(
        color: AppColors.secondaryColor,
        size: Appdimens.dimen35,
      ));

  static Widget getDataNotFoundView({String? msg}) => Center(
          child: Text(
        msg ?? AppStrings.dataNotFound,
        style: Get.theme.textTheme.headlineLarge,
      ));

  static Widget getNetworkImage(String path,
          {double? width,
          double? height,
          BoxFit? fit,
          bool isLoading = true}) =>
      CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) =>
            isLoading ? getLoadingView() : const SizedBox(),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.logo,
          height: height,
          width: width,
        ),
      );

  static AppBar titleBar(String title,
          {bool isBack = true,
          TextAlign? textAlign,
          List<Widget>? actions,
          Function()? onTap}) =>
      AppBar(
        automaticallyImplyLeading: isBack,
        scrolledUnderElevation: 0.0,
        titleTextStyle: Get.theme.textTheme.displaySmall,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: Get.theme.textTheme.displayLarge,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: actions,
      );

  static Widget getDialogView(String title, String msg) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.theme.textTheme.headlineSmall,
          ),
          Text(
            msg,
            style: Get.theme.textTheme.headlineLarge,
          ).paddingSymmetric(vertical: Appdimens.dimen30),
        ],
      );

  static exitDialog() => AppDialogs.showCommonDialog(
        AppWidgets.getDialogView(AppStrings.exit, AppStrings.exitMsg),
        onTap: () => SystemNavigator.pop(),
      );

  static Widget cardContainer(
          {required Widget child,
          double? width,
          double? height,
          EdgeInsetsGeometry? padding,
          BorderRadiusGeometry? borderRadius,
          EdgeInsetsGeometry? margin}) =>
      Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding ?? EdgeInsets.all(Appdimens.dimen20),
        decoration: AppDecoration.cardDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: borderRadius),
        child: child,
      );

  static Widget getRichText(String str1,
          {TextStyle? style1,
          TextStyle? style2,
          String? str2,
          List<InlineSpan>? children,
          TextAlign? textAlign,
          int? maxLines}) =>
      RichText(
        textAlign: textAlign ?? TextAlign.center,
        maxLines: maxLines,
        textScaler: TextScaler.linear(FontDimen.textScaleFactor),
        text: TextSpan(
          text: str1,
          style: style1 ?? Get.theme.textTheme.headlineMedium,
          children: children ??
              <TextSpan>[
                TextSpan(
                    text: ' $str2',
                    style: style2 ??
                        Get.theme.textTheme.headlineMedium
                            ?.copyWith(color: AppColors.primaryColor)),
              ],
        ),
      );

  static Widget getGradintText(String text) => GradientText(
        text,
        style:
            TextStyle(fontSize: FontDimen.dimen14, fontWeight: FontWeight.w500),
        gradientType: GradientType.linear,
        colors: const [AppColors.primaryColor, AppColors.primaryColor],
        stops: const [0.85, 1],
      );
  // static Widget getRowView(String title, String price, {TextStyle? style}) =>
  //     Row(
  //       children: [
  //         Text(
  //           title,
  //           style: style ?? Get.theme.textTheme.titleSmall,
  //         ),
  //         Expanded(
  //             child: const AppSeparator(
  //           color: AppColors.primaryColor,
  //         ).paddingSymmetric(horizontal: Appdimens.dimenW20)),
  //         Text(
  //           price,
  //           style: style ?? Get.theme.textTheme.titleSmall,
  //         ),
  //       ],
  //     );
}
