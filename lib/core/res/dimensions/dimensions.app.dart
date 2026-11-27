import 'package:google_samsung_pay/core/res/dimensions/dimensions.base.dart';

/// Hệ 8pt của spec Figma: padding 2 bên 24, header-tới-tiêu đề 24,
/// tiêu đề-tới-nội dung 16, section 16, option/input 12,
/// nội dung-tới-nút 32, nút-cách-đáy 24, padding trong card 16.
class DimensionsApp extends DimensionsBase {
  @override
  double get primaryPadding => 24.0;
  @override
  double get sidePadding => 24.0;
  @override
  double get headerToTitle => 24.0;
  @override
  double get titleToContent => 16.0;
  @override
  double get sectionGap => 16.0;
  @override
  double get optionGap => 12.0;
  @override
  double get contentToButton => 32.0;
  @override
  double get buttonToBottom => 24.0;
  @override
  double get cardPadding => 16.0;
}
