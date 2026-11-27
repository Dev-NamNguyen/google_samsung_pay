import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/app.context.extension.dart';
import 'package:google_samsung_pay/core/res/colors/colors.base.dart';

class BaseScafford extends StatelessWidget {
  final Widget? child;
  final String? title;
  final Color? backgroundColor;
  final Widget? bottom;
  final PreferredSizeWidget? appBarBottom;
  const BaseScafford({
    super.key,
    required this.child,
    this.title,
    this.backgroundColor,
    this.bottom,
    this.appBarBottom,
  });

  @override
  Widget build(BuildContext context) {
    ColorsBase colors = context.resources.colors;
    return Scaffold(
      bottomNavigationBar: bottom,
      appBar: AppBar(
        bottom: appBarBottom,
        backgroundColor: colors.backgroundColor,
        centerTitle: false,
        title: Text(
          title ?? 'Đăng ký thẻ & Samsung Pay',
          style: TextStyle(
            color: colors.themeColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: colors.themeColor, size: 24),
        ),
      ),
      body: child != null
          ? Container(
              color: backgroundColor ?? colors.backgroundColor,
              child: SafeArea(child: child ?? Container()),
            )
          : Container(
              color: colors.backgroundColor,
              alignment: Alignment.center,
              child: const Text(
                'No content available',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
    );
  }
}
