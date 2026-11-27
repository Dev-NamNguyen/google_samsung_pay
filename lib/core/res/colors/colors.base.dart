import 'dart:ui';

// Copied from shopping (vnb_ban_hang) ColorsBase, extended with the
// Samsung Pay white-minimal palette so screens can reach every accent
// through context.resources.colors.
abstract class ColorsBase {
  Color get primaryColor;
  Color get themeColor;
  Color get secondThemeColor;
  Color get backgroundColor;
  Color get textDarkColor;
  Color get notPriorityColor;
  Color get productCardBackground;
  Color get delete;
  Color get formBackground;
  Color get itemColor;
  Color get itemColor2;

  // Samsung Pay palette (spec Figma trắng minimal).
  Color get volt;
  Color get voltPale;
  Color get blueNeon;
  Color get bluePale;
  Color get samsungNavy;
  Color get errorRed;
  Color get errorRedPale;
  Color get greyText;
  Color get greyLight;
  Color get greyBorder;
  Color get backgroundAlt;
}
