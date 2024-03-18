import 'package:disease_tracker/config/app_config.dart';
import 'package:disease_tracker/screens/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.off(const LoginScreen());
    });
    return Scaffold(
      body: Center(
          child: Image.asset(AppImages.logo).paddingAll(Appdimens.dimen50)),
    );
  }
}
