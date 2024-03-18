

import 'package:disease_tracker/config/app_config.dart';

extension CustomExtensions on Widget {
  GestureDetector asButton({required Function() onTap}) => GestureDetector(
        onTap: onTap,
        child: this,
      );

  Align align({AlignmentGeometry alignment = Alignment.center}) => Align(
        alignment: alignment,
        child: this,
      );
}
