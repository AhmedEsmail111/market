import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';

// Default TextFormField in my app

class BuildDefaultTextField extends StatelessWidget {
  final TextInputType inputType;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? onValidate;
  final String hintText;
  final bool isObscured;
  final String? aboveFieldText;
  final BuildContext? context;
  final void Function()? onSuffixTaped;
  final bool withText;
  final double width;
  final double height;
  final IconData? suffixIcon;
  final int maxLength;
  final Color backGroundColor;
  final Icon? prefixIcon;
  final int? numberOfFormPass;
  final int? maxLines;
  final void Function(String)? onChange;
  final bool withEyeVisible;
  final bool? isEnabled;
  final String? initialFieldValue;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final bool autoFocus;
  const BuildDefaultTextField({
    super.key,
    this.numberOfFormPass,
    this.withEyeVisible = false,
    required this.inputType,
    this.withText = true,
    required this.hintText,
    this.aboveFieldText,
    this.prefixIcon,
    required this.backGroundColor,
    this.context,
    required this.width,
    required this.height,
    required this.maxLength,
    this.onSaved,
    this.onValidate,
    required this.isObscured,
    this.onChange,
    this.isEnabled,
    this.maxLines,
    this.initialFieldValue,
    this.suffixIcon,
    this.onSuffixTaped,
    this.controller,
    this.onSubmitted,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withText == true)
          Text(
            aboveFieldText!,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.left,
          ),
        if (withText == true) SizedBox(height: 4.h),
        Material(
          color:
              isDark ? const Color.fromARGB(255, 92, 91, 91) : backGroundColor,
          elevation: 1,
          shadowColor: const Color.fromARGB(255, 252, 251, 251),
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? const Color.fromARGB(255, 92, 91, 91)
                  : backGroundColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            width: width,
            child: TextFormField(
                autofocus: autoFocus,
                onFieldSubmitted: onSubmitted,
                controller: controller,
                initialValue: initialFieldValue,
                enabled: isEnabled,
                onChanged: onChange,
                maxLength: maxLength,
                maxLines: maxLines ?? 1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black),
                obscureText: isObscured,
                keyboardType: inputType,
                decoration: InputDecoration(
                  errorBorder: InputBorder.none,
                  // error: Container(
                  //   color:
                  //       isDark ? blackColor.withOpacity(0.3) : backGroundColor,
                  // ),
                  prefixIconColor: isDark
                      ? Colors.deepOrange
                      : Theme.of(context).colorScheme.primary,
                  suffixIconColor: isDark
                      ? Colors.deepOrange
                      : Theme.of(context).colorScheme.primary,
                  counterText: '',
                  errorStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.red),
                  filled: true,
                  fillColor: isDark
                      ? const Color.fromARGB(255, 92, 91, 91)
                      : backGroundColor,
                  hintText: hintText,
                  hintStyle: const TextStyle().copyWith(
                      color: isDark
                          ? const Color.fromARGB(255, 151, 146, 146)
                          : Colors.black26,
                      fontSize: 14),
                  // enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(
                  //         color: Theme.of(context).colorScheme.secondary)),

                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  prefixIcon: prefixIcon,
                  suffixIcon: withEyeVisible
                      ? GestureDetector(
                          onTap: onSuffixTaped,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 20,
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 40,
                            ),
                            alignment: Alignment.centerRight,
                            child: Icon(suffixIcon),
                          ))
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 25,
                    vertical: MediaQuery.of(context).size.width / 50,
                  ),
                ),
                onSaved: (newValue) {
                  // you have to check if the newValue is not null before doing any work with it
                  onSaved!(newValue!);
                },
                // you have to check if the newValue is not null before doing any work with it
                validator: onValidate),
          ),
        ),
      ],
    );
  }
}
