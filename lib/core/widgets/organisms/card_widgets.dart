import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:google_samsung_pay/core/res/colors/colors.app.dart';

/// Logo Visa vẽ bằng text (không dùng asset ngoài).
class VisaLogo extends StatelessWidget {
  const VisaLogo({super.key, this.fontSize = 22, this.color = Colors.white});

  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'VISA',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        color: color,
        letterSpacing: 1,
      ),
    );
  }
}

/// Logo Mastercard: 2 vòng tròn chồng nhau.
class MastercardLogo extends StatelessWidget {
  const MastercardLogo({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 1.6,
      height: size,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: const Color(0xFFF79E1B).withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Thẻ trắng gradient nhẹ, chip, số thẻ, logo — KHÔNG solid, KHÔNG đen.
class WhiteCard extends StatelessWidget {
  const WhiteCard({
    super.key,
    required this.brand,
    required this.last4,
    this.cardNumber = '4242 •••• •••• 4242',
    this.holder = 'SOPHIA',
    this.expiry = '12/28',
    this.width = double.infinity,
    this.height = 200,
    this.dimmed = false,
    this.redBorder = false,
    this.showBadgeX = false,
  });

  final String brand; // 'visa' | 'mastercard'
  final String last4;
  final String cardNumber;
  final String holder;
  final String expiry;
  final double width;
  final double height;
  final bool dimmed;
  final bool redBorder;
  final bool showBadgeX;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        gradient: whiteCardGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: redBorder ? AppColors.errorRed : AppColors.greyLight,
          width: redBorder ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Chip
              Container(
                width: 44,
                height: 32,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD76A), Color(0xFFE8B93C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(Icons.credit_card, size: 18,
                    color: Color(0xFF7A5A00)),
              ),
              const Text(
                'Debit',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.greyText,
                  letterSpacing: 1,
                ),
              ),
              brand == 'visa'
                  ? const VisaLogo(color: Color(0xFF1A1F71), fontSize: 20)
                  : const MastercardLogo(size: 28),
            ],
          ),
          const Spacer(),
          Text(
            cardNumber,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CHỦ THẺ',
                      style: TextStyle(fontSize: 9, color: AppColors.greyText)),
                  Text(holder,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('HẾT HẠN',
                      style: TextStyle(fontSize: 9, color: AppColors.greyText)),
                  Text(expiry,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w700)),
                ],
              ),
              Text(
                '•• $last4',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );

    final wrapped = Opacity(opacity: dimmed ? 0.55 : 1, child: card);
    if (!showBadgeX) return wrapped;
    // Badge X đỏ góc trên-phải thẻ (audit 25/11: khỏi che logo Visa).
    return Stack(
      clipBehavior: Clip.none,
      children: [
        wrapped,
        Positioned(
          top: -10,
          right: -6,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.errorRed,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}

/// Vòng tick gradient lớn (màn 4 & 8).
class GradientTick extends StatelessWidget {
  const GradientTick({super.key, required this.screen, this.size = 96});

  final int screen;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: primaryGradient(screen),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueNeon.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(Icons.check, color: AppColors.black, size: size * 0.55),
    );
  }
}

/// Vòng X đỏ lớn (màn lỗi 09).
class RedXCircle extends StatelessWidget {
  const RedXCircle({super.key, this.size = 96});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.errorRedPale,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.close, color: AppColors.errorRed, size: size * 0.55),
    );
  }
}

/// Vân tay vẽ chi tiết bằng CustomPaint — KHÔNG chỉ icon tròn (spec màn 6).
/// Các cung đồng tâm lệch nhau + highlight xanh #00B2FF ở giữa.
class FingerprintPainter extends CustomPainter {
  FingerprintPainter({this.baseColor = AppColors.ink});

  final Color baseColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    final highlight = Paint()
      ..color = AppColors.blueNeon
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    // Các cung vân tay: vòng elip đồng tâm, mỗi vòng chỉ vẽ một phần cung
    // để tạo cảm giác vân xoắn như vân tay thật.
    for (var i = 0; i < 7; i++) {
      final r = 12.0 + i * 9.0;
      final start = -0.4 + i * 0.22;
      final sweep = math.pi * 1.55 - i * 0.08;
      canvas.drawArc(
        Rect.fromCenter(
          center: center,
          width: r * 2,
          height: r * 2.3,
        ),
        start,
        sweep,
        false,
        i == 2 || i == 3 ? highlight : paint,
      );
    }
    // Nét vân giữa: đường cong chữ S.
    final mid = Path()
      ..moveTo(center.dx - 6, center.dy - 42)
      ..quadraticBezierTo(
          center.dx + 14, center.dy - 10, center.dx - 4, center.dy + 18)
      ..quadraticBezierTo(
          center.dx - 14, center.dy + 34, center.dx + 2, center.dy + 46);
    canvas.drawPath(mid, highlight);
  }

  @override
  bool shouldRepaint(covariant FingerprintPainter oldDelegate) =>
      oldDelegate.baseColor != baseColor;
}

class FingerprintView extends StatelessWidget {
  const FingerprintView({
    super.key,
    this.size = 160,
    this.withBadgeX = false,
  });

  final double size;
  final bool withBadgeX;

  @override
  Widget build(BuildContext context) {
    final fp = SizedBox(
      width: size,
      height: size * 1.15,
      child: CustomPaint(painter: FingerprintPainter()),
    );
    if (!withBadgeX) return fp;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        fp,
        Positioned(
          right: -4,
          top: 4,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.errorRed,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }
}

/// 6 ô OTP riêng biệt (màn 3) — hoặc 6 ô đỏ hiển thị sẵn (màn 9).
class OtpBoxes extends StatelessWidget {
  const OtpBoxes({
    super.key,
    this.controllers,
    this.onChanged,
    this.error = false,
    this.fixedDigits,
    this.activeIndex = 5,
  });

  final List<TextEditingController>? controllers;
  final void Function(String)? onChanged;
  final bool error;
  final String? fixedDigits; // vd '428516' cho màn lỗi 09
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    // 6 ô cố định 48px + 5 khoảng 12px = 348px, rộng hơn 342px nội dung
    // của màn 390 (padding 2 bên 24) nên Row bị overflow 6px — và càng
    // hẹp càng tràn (màn 360 tràn 36px). Cho mỗi ô co giãn bằng Expanded
    // theo chiều rộng thật: ở 390 ô rộng 47px, vẫn đúng tỉ lệ Figma.
    final boxes = List<Widget>.generate(6, (i) {
      final isActive = !error && i == activeIndex;
      final border = error
          ? Border.all(color: AppColors.errorRed, width: 2)
          : isActive
              ? Border.all(color: AppColors.blueNeon, width: 2)
              : Border.all(color: AppColors.greyBorder, width: 1.5);
      Widget box;
      if (fixedDigits != null) {
        box = Center(
          child: Text(
            fixedDigits![i],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.errorRed,
            ),
          ),
        );
      } else {
        box = TextField(
          controller: controllers?[i],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (v) {
            if (v.isNotEmpty && i < 5) {
              FocusScope.of(context).nextFocus();
            } else if (v.isEmpty && i > 0) {
              FocusScope.of(context).previousFocus();
            }
            onChanged?.call(v);
          },
        );
      }
      return Expanded(
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: error ? AppColors.errorRedPale : AppColors.backgroundAlt,
            borderRadius: BorderRadius.circular(14),
            border: border,
          ),
          child: box,
        ),
      );
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < boxes.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          boxes[i],
        ],
      ],
    );
  }
}
