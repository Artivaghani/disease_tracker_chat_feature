import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/utils/app_decoration.dart';
import 'package:disease_tracker/widgets/app_btn.dart';

class AppDialogs {
  static successSnackBar(String msg) {
    if (msg.isNotEmpty) {
      return ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            backgroundColor: AppColors.greenColor,
            content: Text(
              msg,
              style: TextStyle(
                  fontSize: FontDimen.dimen14, color: AppColors.secondaryColor),
            )),
      );
    }
  }

  static errorSnackBar(String msg) {
    if (msg.isNotEmpty) {
      return ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            backgroundColor: AppColors.redColor,
            content: Text(
              msg,
              style: TextStyle(
                  fontSize: FontDimen.dimen14, color: AppColors.primaryColor),
            )),
      );
    }
  }

  static showProcess() {
    return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: PopScope(canPop: false, child: AppWidgets.getLoadingView())),
    );
  }

  static showCommonDialog(Widget child,
      {Function()? onTap, bool isOk = false}) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
                decoration: AppDecoration.cardDecoration(
                    color: Get.theme.scaffoldBackgroundColor),
                padding: EdgeInsets.all(Appdimens.dimen20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child,
                    isOk
                        ? appButton(
                            AppStrings.ok,
                            height: Appdimens.dimen50,
                            width: Appdimens.dimen100,
                            onTap: () {
                              Get.back();
                              onTap?.call();
                            },
                          ).align()
                        : Row(
                            children: [
                              Expanded(
                                  child: appButton(
                                AppStrings.no,
                                height: Appdimens.dimen50,
                                color: AppColors.terneryColor,
                                textColor: AppColors.primaryColor,
                                onTap: () => Get.back(),
                              ).paddingSymmetric(
                                      horizontal: Appdimens.dimenW40)),
                              Expanded(
                                  child: appButton(
                                AppStrings.yes,
                                height: Appdimens.dimen50,
                                onTap: () {
                                  Get.back();
                                  onTap?.call();
                                },
                              ).paddingSymmetric(
                                      horizontal: Appdimens.dimenW40)),
                            ],
                          )
                  ],
                )),
          ),
        );
      },
    );
  }
}
