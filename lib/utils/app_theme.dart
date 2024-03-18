import 'package:disease_tracker/config/app_config.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.terneryColor,
      iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      cardColor: AppColors.cardColor,
      hintColor: AppColors.hintColor,
      dividerColor: AppColors.hintColor,
      textTheme: TextTheme(
        displayLarge: getTextStyle(AppColors.secondaryColor, FontDimen.dimen20,
            fontWeight: FontWeight.w500),
        displayMedium: getTextStyle(AppColors.secondaryColor, FontDimen.dimen18,
            fontWeight: FontWeight.w400),
        displaySmall: getTextStyle(AppColors.secondaryColor, FontDimen.dimen16,
            fontWeight: FontWeight.w400),
        headlineLarge: getTextStyle(
          AppColors.secondaryColor,
          fontWeight: FontWeight.w500,
          FontDimen.dimen14,
        ),
        headlineMedium: getTextStyle(
          AppColors.secondaryColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen12,
        ),
        headlineSmall: getTextStyle(
          AppColors.secondaryColor,
          fontWeight: FontWeight.w700,
          FontDimen.dimen20,
        ),
        titleLarge: getTextStyle(
          AppColors.terneryColor,
          fontWeight: FontWeight.w700,
          FontDimen.dimen12,
        ),
        titleMedium: getTextStyle(
          AppColors.terneryColor,
          fontWeight: FontWeight.w500,
          FontDimen.dimen10,
        ),
      ));
}

TextStyle getTextStyle(Color color, double size,
        {FontWeight? fontWeight, String? fontFamily}) =>
    GoogleFonts.dmSans(
        textStyle:
            TextStyle(color: color, fontSize: size, fontWeight: fontWeight));
