import 'package:disease_tracker/config/app_config.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? tag;
  final double? height;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Color? color;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool readOnly;
  final Decoration? decoration;
  final BorderRadius? borderRadius;

  const AppTextField(
      {super.key,
      this.hintText,
      this.tag,
      this.height,
      this.controller,
      this.focusNode,
      this.contentPadding,
      this.keyboardType,
      this.obscureText = false,
      this.onChanged,
      this.validator,
      this.maxLength,
      this.color,
      this.suffixIcon,
      this.onTap,
      this.borderRadius,
      this.readOnly = false,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      style: Get.theme.textTheme.headlineLarge,
      cursorColor: Get.theme.primaryColor,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      readOnly: readOnly,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Get.theme.textTheme.headlineLarge!
              .copyWith(color: AppColors.primaryColor.withOpacity(0.4),height: 0.4),
          suffixIcon: suffixIcon,
          isDense: true,
          isCollapsed: true,
          filled: true,
          fillColor: AppColors.primaryColor.withOpacity(0.1),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                  horizontal: Appdimens.dimen20, vertical: Appdimens.dimen10),
          border: getOutline(borderRadius: borderRadius),
          enabledBorder: getOutline(borderRadius: borderRadius),
          errorBorder: getOutline(borderRadius: borderRadius)),
    );
  }

  getOutline({BorderRadius? borderRadius}) => OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: borderRadius ?? BorderRadius.circular(Appdimens.dimen6));
}
