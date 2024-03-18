import 'package:disease_tracker/config/app_config.dart';

class StorageHelper {
  get storage => GetStorage();

  set isDoctor(bool value) => storage.write("isDoctor", value);
  bool get isDoctor => storage.read('isDoctor') ?? false;
}
