import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/colors/colors.base.dart';

/// Palette Samsung Pay trắng minimal — thay cho cam #F36522 / đỏ #BE2728
/// của shop. themeColor = volt #CCFF00, secondThemeColor = xanh #00B2FF.
class ColorsApp extends ColorsBase {
  @override
  Color get primaryColor => const Color(0xFF00B2FF);
  @override
  Color get itemColor => const Color(0xFF111111);
  @override
  Color get itemColor2 => const Color(0xFF00B2FF);
  @override
  Color get themeColor => const Color(0xFFCCFF00);
  @override
  Color get secondThemeColor => const Color(0xFF00B2FF);
  @override
  Color get backgroundColor => Colors.white;
  @override
  Color get textDarkColor => Colors.white;
  @override
  Color get notPriorityColor => Colors.grey[400]!;
  @override
  Color get productCardBackground => const Color(0xFFD6F0FF);
  @override
  Color get delete => const Color(0xFFFF3B30);
  @override
  Color get formBackground => const Color(0xFFF5F5F7);
  @override
  Color get volt => const Color(0xFFCCFF00);
  @override
  Color get voltPale => const Color(0xFFEFFF99);
  @override
  Color get blueNeon => const Color(0xFF00B2FF);
  @override
  Color get bluePale => const Color(0xFFD6F0FF);
  @override
  Color get samsungNavy => const Color(0xFF1428A0);
  @override
  Color get errorRed => const Color(0xFFFF3B30);
  @override
  Color get errorRedPale => const Color(0xFFFFE9E8);
  @override
  Color get greyText => const Color(0xFF6B7280);
  @override
  Color get greyLight => const Color(0xFFE5E7EB);
  @override
  Color get greyBorder => const Color(0xFFD1D5DB);
  @override
  Color get backgroundAlt => const Color(0xFFF5F5F7);
}

/// Static tokens kept for the Figma widgets (thẻ, OTP, vân tay) so they
/// don't need a BuildContext — same values as ColorsApp above.
class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFF5F5F7);
  static const Color black = Color(0xFF000000);
  static const Color ink = Color(0xFF111111);
  static const Color greyText = Color(0xFF6B7280);
  static const Color greyLight = Color(0xFFE5E7EB);
  static const Color greyBorder = Color(0xFFD1D5DB);
  static const Color volt = Color(0xFFCCFF00);
  static const Color voltPale = Color(0xFFEFFF99);
  static const Color blueNeon = Color(0xFF00B2FF);
  static const Color bluePale = Color(0xFFD6F0FF);
  static const Color samsungNavy = Color(0xFF1428A0);
  static const Color errorRed = Color(0xFFFF3B30);
  static const Color errorRedPale = Color(0xFFFFE9E8);
  static const Color successGreen = Color(0xFF00C853);
}

/// 8pt spacing system from the Figma spec (spacing pass 24/11).
class AppSpacing {
  static const double side = 24;
  static const double headerToTitle = 24;
  static const double titleToContent = 16;
  static const double section = 16;
  static const double option = 12;
  static const double contentToButton = 32;
  static const double buttonToBottom = 24;
  static const double cardPadding = 16;
}

/// Primary-button gradient direction per screen (spec 23/11, audit 25/11).
/// 1 LR volt->blue, 2 RL blue->volt, 3 TB volt->blue, 4 diag TL-BR,
/// 5 LR reversed blue->volt, 6 TB reversed blue->volt,
/// 7 diag BL-TR, 8 LR volt->blue, 9 TB volt->blue (audit: same as 03),
/// 10 RL blue->volt, 11 TB volt->blue.
LinearGradient primaryGradient(int screen) {
  const volt = AppColors.volt;
  const blue = AppColors.blueNeon;
  switch (screen) {
    case 1:
      return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [volt, blue],
      );
    case 2:
      return const LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [volt, blue],
      );
    case 3:
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [volt, blue],
      );
    case 4:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [volt, blue],
      );
    case 5:
      return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [blue, volt],
      );
    case 6:
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [blue, volt],
      );
    case 7:
      return const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [volt, blue],
      );
    case 8:
      return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [volt, blue],
      );
    case 9:
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [volt, blue],
      );
    case 10:
      return const LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [volt, blue],
      );
    case 11:
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [volt, blue],
      );
    default:
      return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [volt, blue],
      );
  }
}

/// Pale gradient for the "Mặc định" / "Miễn phí" pills.
LinearGradient paleGradient({bool diagonal = false}) {
  return LinearGradient(
    begin: diagonal ? Alignment.topLeft : Alignment.centerLeft,
    end: diagonal ? Alignment.bottomRight : Alignment.centerRight,
    colors: const [AppColors.bluePale, AppColors.voltPale],
  );
}

/// White card gradient (trắng -> xám rất nhạt), never solid, never black.
const LinearGradient whiteCardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFFF), Color(0xFFF1F1F3)],
);
