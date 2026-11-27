import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/app.context.extension.dart';
import 'package:google_samsung_pay/core/widgets/atoms/theme.button.dart';

class BorderThemeButton extends StatefulWidget {
  /// type using enum [ThemeButtonType]
  /// default is [ThemeButtonType.large]
  /// if you want to use [ThemeButtonType.mediumn] or [ThemeButtonType.small]
  /// you can set it like this:
  /// ```dart
  /// ThemeButton(type: ThemeButtonType.mediumn)
  /// ```
  /// if you want to use [ThemeButtonType.small]
  /// you can set it like this:
  /// ```dart
  /// ThemeButton(type: ThemeButtonType.small)
  /// ```
  /// if you want to use [ThemeButtonType.large]
  /// you can set it like this:
  /// ```dart
  /// ThemeButton(type: ThemeButtonType.large)
  /// ```
  /// if you want to use default [ThemeButtonType.large]
  /// you can set it like this:
  /// ```dart
  /// ThemeButton()
  final ThemeButtonType type;

  /// title of button, default is null
  /// if you want to use title, you can set it like this:
  /// ```dart
  /// ThemeButton(title: "Đăng ký")
  /// ```
  /// It's required to set title for button
  final String title;

  /// titleStyle is used to customize the style of title
  final TextStyle? titleStyle;

  /// onPressed is used to handle button press event
  final Function()? onPressed;

  /// backgroundTheme is used to customize the background color of button
  final Color? backgroundTheme;

  /// indicatorAction is used to show action when button is pressed
  /// if you want to customize the action
  final Widget? indicatorAction;

  /// isLoading is used to show loading indicator
  final bool isLoading;

  /// isDisabled is used to disable button
  final bool isDisabled;
  const BorderThemeButton({
    super.key,
    this.type = ThemeButtonType.large,
    required this.title,
    this.titleStyle,
    this.backgroundTheme,
    this.onPressed,
    this.indicatorAction,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<BorderThemeButton> createState() => _BorderThemeButtonState();
}

class _BorderThemeButtonState extends State<BorderThemeButton> {
  bool _isLoading = false;
  bool _isDisabled = false;
  Color _themeColor = Colors.transparent;

  void setDisabled(bool disabled) {
    setState(() {
      _isDisabled = disabled;
    });
  }

  /// set loading state
  void setLoading(bool loading) {
    setDisabled(loading);
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _isDisabled = widget.isDisabled;
    _themeColor = widget.backgroundTheme ?? context.resources.colors.themeColor;
  }

  @override
  void didUpdateWidget(covariant BorderThemeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDisabled != widget.isDisabled) {
      setDisabled(widget.isDisabled);
    }
    _themeColor = widget.backgroundTheme ?? context.resources.colors.themeColor;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.resources.colors;
    double getWidthFactor(ThemeButtonType type) {
      switch (type) {
        case ThemeButtonType.large:
          return 1;
        case ThemeButtonType.medium:
          return 0.7;
        case ThemeButtonType.small:
          return 0.4;
      }
    }

    double sizeText(ThemeButtonType type) {
      switch (type) {
        case ThemeButtonType.large:
          return 14;
        case ThemeButtonType.medium:
          return 14;
        case ThemeButtonType.small:
          return 12;
      }
    }

    return FractionallySizedBox(
      widthFactor: getWidthFactor(widget.type),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          overlayColor: colors.backgroundColor,
          surfaceTintColor: colors.backgroundColor,
          shadowColor: colors.backgroundColor,
          backgroundColor:
              _isDisabled ? Colors.grey.shade50 : colors.backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: _themeColor, width: 1),
          ),
        ),
        onPressed: () async {
          if (_isLoading || _isDisabled) return;
          setLoading(true);
          await Future.delayed(const Duration(milliseconds: 1000), () async {
            await widget.onPressed?.call();
          });

          setLoading(false);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: _isLoading
              ? Center(
                  child: widget.indicatorAction ??
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: _themeColor,
                          strokeWidth: 2.0,
                        ),
                      ),
                )
              : Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.title,
                    style: widget.titleStyle ??
                        TextStyle(
                          fontSize: sizeText(widget.type),
                          color: _themeColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
        ),
      ),
    );
  }
}
