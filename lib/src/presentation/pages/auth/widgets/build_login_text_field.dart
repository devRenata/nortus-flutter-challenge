import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildLoginTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const BuildLoginTextField({
    super.key,
    this.controller,
    required this.label,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  State<BuildLoginTextField> createState() => _BuildLoginTextFieldState();
}

class _BuildLoginTextFieldState extends State<BuildLoginTextField> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppColors.secondary,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: AppColors.textBlack,
        hintStyle: TextStyle(color: AppColors.textGray),
        labelStyle: TextStyle(color: AppColors.textGray),
        floatingLabelStyle: TextStyle(color: hasError ? AppColors.error : AppColors.secondary),
        errorStyle: const TextStyle(color: AppColors.error),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderGray),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        final validator = widget.validator;
        final error = validator?.call(value);
        setState(() {
          hasError = error != null;
        });
        return error;
      }
    );
  }
}
