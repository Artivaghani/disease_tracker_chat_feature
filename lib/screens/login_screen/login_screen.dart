import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/screens/message_screen/message_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppWidgets.cardContainer(
            width: double.infinity,
            child: Text(
              AppStrings.joinAsDoctor,
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.displaySmall,
            ),
          ).asButton(
            onTap: () {
              StorageHelper().isDoctor = true;
              Get.off(() => const MessageScreen());
            },
          ),
          AppWidgets.cardContainer(
              width: double.infinity,
              child: Text(
                AppStrings.joinAsPatient,
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.displaySmall,
              )).paddingOnly(top: Appdimens.dimen30).asButton(
            onTap: () {
              StorageHelper().isDoctor = false;
              Get.off(() => const MessageScreen());
            },
          ),
        ],
      ).paddingAll(Appdimens.dimen50),
    );
  }
}
