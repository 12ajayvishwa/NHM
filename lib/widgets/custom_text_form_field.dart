import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_export.dart';

import '../theme/color_constants.dart';
import '../theme/text_style.dart';
import '../theme/theme_helper.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.alignment,
      this.width,
      this.scrollPadding,
      this.margin,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.validator,
      this.readOnly = false,
      this.onTap,
      this.labelText,
      this.maxLength,
      this.inputFormatters,
      this.footerText,
      this.initialValue,
      this.onChanged,
      this.borderRadius,
      this.enabledBorderColor})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final Function(String)? onChanged;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final EdgeInsets? scrollPadding;

  final TextStyle? textStyle;
  final bool? obscureText;
  final bool readOnly;
  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;
  final Color? enabledBorderColor;

  final void Function()? onTap;

  final String? labelText;

  final int? maxLength;

  final BorderRadius? borderRadius;

  final List<TextInputFormatter>? inputFormatters;

  final FormFieldValidator<dynamic>? validator;

  final String? footerText;

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        margin: margin,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                labelText != null
                    ? Text(labelText!,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.textFieldLabel)
                    : const SizedBox(),
                labelText != null ? SizedBox(height: 5.h) : const SizedBox(),
                TextFormField(
                  scrollPadding:scrollPadding ?? const EdgeInsets.all(0.0),
                  maxLength: maxLength,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTap: onTap,
                  controller: controller,
                  initialValue: initialValue,
 buildCounter: (context,
                          {int? currentLength,
                          bool? isFocused,
                          int? maxLength}) =>
                      null,
                  // focusNode: focusNode ?? FocusNode(),
                  inputFormatters: inputFormatters,
                  onChanged: onChanged,
                  autofocus: autofocus!,
                  style: textStyle ?? AppTextStyles.bodyText,
                  obscureText: obscureText!,
                  textInputAction: textInputAction,
                  keyboardType: textInputType,
                  maxLines: maxLines ?? 1,
                  decoration: decoration,
                  validator: validator,
                  readOnly: readOnly,
                ),
              ],
            ),
            footerText != null
                ? Text(footerText!,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12.sp, color: appTheme.gray))
                : const SizedBox(),
          ],
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        //  helperText: "jhgg",
        hintStyle: hintStyle ?? AppTextStyles.hintText,
        labelStyle: AppTextStyles.hintText,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        counterStyle: const TextStyle(color: Colors.black),
        errorStyle: const TextStyle(color: Colors.red),
        contentPadding: contentPadding ?? EdgeInsets.all(15.h),
        fillColor: fillColor ?? appTheme.fieldFillColor,
        filled: filled,
        
        border: borderDecoration ??
            OutlineInputBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                borderSide: BorderSide.none),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: enabledBorderColor ?? Colors.transparent,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: AppColors.kprimary.withOpacity(0.2),
                width: 1,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.h),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      );
}

