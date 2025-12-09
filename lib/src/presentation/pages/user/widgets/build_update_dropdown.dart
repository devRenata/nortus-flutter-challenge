import 'package:flutter/material.dart';
import 'package:nortus/src/presentation/themes/app_colors.dart';

class BuildUpdateDropdown extends StatelessWidget {
  final List<String> options;
  final String title;
  final String hintText;
  final void Function(String)? onChanged;

  const BuildUpdateDropdown({
    required this.options,
    required this.hintText,
    required this.title,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          dropdownColor: AppColors.white,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.textGray,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: AppColors.secondary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: AppColors.secondary,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: AppColors.secondary,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textGray,
            size: 20,
          ),
          items: options.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onChanged?.call(value);
          },
        ),
      ],
    );
  }
}
