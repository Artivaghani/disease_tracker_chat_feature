import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:disease_tracker/config/app_config.dart';

class AppFunctions {
  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static String getGroupId(String id) {
    String cId = StorageHelper().isDoctor ? '101' : '102';

    if (id.hashCode < cId.hashCode) {
      return '${id}_$cId';
    } else {
      return '${cId}_$id';
    }
  }
}
