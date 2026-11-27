import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/colors/colors.app.dart';

/// Nút chính gradient volt -> xanh, chữ đen, bo 16, cao 56.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.screen,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.icon,
  });

  final int screen;
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final active = enabled && onPressed != null;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: active ? primaryGradient(screen) : null,
          color: active ? null : AppColors.greyLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: active ? onPressed : null,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: AppColors.black, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: active ? AppColors.black : AppColors.greyText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
