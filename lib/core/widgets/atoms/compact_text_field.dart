import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/app.context.extension.dart';

class CompactTextField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool? isPasswordVisible;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function()? onTogglePassword;
  final TextInputAction? textInputAction;
  const CompactTextField({
    super.key,
    this.label,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.isPasswordVisible,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTogglePassword,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            textInputAction: textInputAction,
            controller: controller,
            obscureText: isPassword && !(isPasswordVisible ?? false),
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              prefixIcon: prefixIcon != null
                  ? Container(
                      margin: const EdgeInsets.only(left: 16, right: 12),
                      child: Icon(
                        prefixIcon,
                        color: context.resources.colors.themeColor.withValues(alpha: 
                          0.7,
                        ),
                        size: 20,
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 48),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        (isPasswordVisible ?? false)
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      onPressed: onTogglePassword,
                    )
                  : null,
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: context.resources.colors.themeColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              errorMaxLines: 1,
              errorStyle: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
