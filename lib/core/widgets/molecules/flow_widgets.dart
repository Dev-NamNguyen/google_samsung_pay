import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/routes/route_names.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/widgets/atoms/gradient_theme.button.dart';

/// Status bar kiểu Figma: '9:41' + '5G' (vẽ trong frame, không phải
/// status bar thật của máy).
class FigmaStatusBar extends StatelessWidget {
  const FigmaStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              Text(
                '5G',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 6),
              Icon(Icons.signal_cellular_alt, size: 16),
              SizedBox(width: 4),
              Icon(Icons.wifi, size: 16),
              SizedBox(width: 4),
              Icon(Icons.battery_full, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

/// Step pill — gradient theo hướng nút của màn đó (spec 23/11 18:52).
/// Nhãn theo Figma live 27/11: 'BƯỚC 1/4', 'SAMSUNG PAY • 1/4',
/// 'LỖI OTP • 1/3', ...
class StepPill extends StatelessWidget {
  const StepPill({super.key, required this.screen, required this.label});

  final int screen;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: primaryGradient(screen),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
      ),
    );
  }
}

/// Pill bước + thanh tiến trình 4 đoạn, đoạn đã qua tô đầy.
class StepHeader extends StatelessWidget {
  const StepHeader({
    super.key,
    required this.screen,
    required this.step,
    required this.flowLabel,
    this.pillLabel,
  });

  final int screen;
  final int step; // 1..4 (màn lỗi dùng step của flow gốc)
  final String flowLabel;
  final String? pillLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StepPill(
              screen: screen,
              label: pillLabel ?? 'BƯỚC $step/4',
            ),
            if (flowLabel.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                flowLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyText,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(4, (i) {
            final done = i < step;
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: i == 3 ? 0 : 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: done ? primaryGradient(screen) : null,
                  color: done ? null : AppColors.greyLight,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// Nút phụ trắng, viền xám nhạt.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.greyBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.ink, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Khung màn flow: căn giữa, rộng tối đa 390 (khổ thiết kế 390x844),
/// padding 2 bên 24, nút đáy cách đáy 24, nội dung tới nút 32.
/// Chrome chung theo Figma live 27/11: status bar '9:41' + '5G',
/// nav '< Thanh toán' + 'Sophia' góc phải, dòng 'Được mã hóa và bảo mật'
/// có icon khóa gần cuối, home indicator đáy.
class FlowScreen extends StatelessWidget {
  const FlowScreen({
    super.key,
    required this.screen,
    required this.step,
    required this.flowLabel,
    required this.title,
    this.subtitle,
    required this.child,
    this.primaryLabel,
    this.onPrimary,
    this.primaryEnabled = true,
    this.secondaryLabel,
    this.onSecondary,
    this.footer,
    this.showBack = true,
    this.errorHeader,
    this.pillLabel,
    this.showSecureLine = true,
  });

  final int screen;
  final int step;
  final String flowLabel;
  final String title;
  final String? subtitle;
  final Widget child;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final bool primaryEnabled;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final Widget? footer;
  final bool showBack;
  final String? errorHeader;
  final String? pillLabel;
  final bool showSecureLine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pushNamed(RouteNames.initial);
                  }
                },
              )
            : null,
        title: errorHeader == null
            ? const Text(
                'Thanh toán',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              )
            : Text(
                errorHeader!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.errorRed,
                  letterSpacing: 1.2,
                ),
              ),
        actions: [
          const Center(
            child: Text(
              'Sophia',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: primaryGradient(screen),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'S',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.black),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, size: 20),
            tooltip: 'Danh sách màn hình',
            onPressed: () =>
                Navigator.of(context).pushNamed(RouteNames.initial),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.side,
                    8,
                    AppSpacing.side,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FigmaStatusBar(),
                      StepHeader(
                        screen: screen,
                        step: step,
                        flowLabel: flowLabel,
                        pillLabel: pillLabel,
                      ),
                      const SizedBox(height: AppSpacing.headerToTitle),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                          height: 1.2,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.greyText,
                            height: 1.4,
                          ),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.titleToContent),
                      child,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.side,
                  AppSpacing.contentToButton,
                  AppSpacing.side,
                  AppSpacing.buttonToBottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (primaryLabel != null)
                      GradientButton(
                        screen: screen,
                        label: primaryLabel!,
                        onPressed: onPrimary,
                        enabled: primaryEnabled,
                      ),
                    if (secondaryLabel != null) ...[
                      const SizedBox(height: AppSpacing.option),
                      SecondaryButton(
                        label: secondaryLabel!,
                        onPressed: onSecondary,
                      ),
                    ],
                    if (footer != null) ...[
                      const SizedBox(height: AppSpacing.option),
                      footer!,
                    ],
                    if (showSecureLine) ...[
                      const SizedBox(height: AppSpacing.section),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline,
                              size: 14, color: AppColors.greyText),
                          SizedBox(width: 6),
                          Text(
                            'Được mã hóa và bảo mật',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.greyText),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Home indicator đáy (Figma).
                      Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tiêu đề section nhỏ trong màn.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.greyText,
        letterSpacing: 0.4,
      ),
    );
  }
}

/// Pill "Mặc định" / "Miễn phí" — gradient nhạt, màn 7 chéo thật TL-BR.
class PalePill extends StatelessWidget {
  const PalePill(this.text, {super.key, this.diagonal = false});

  final String text;
  final bool diagonal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: paleGradient(diagonal: diagonal),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
    );
  }
}
