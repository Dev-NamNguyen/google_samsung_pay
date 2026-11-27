// Tạo một PageRoute tùy chỉnh (ví dụ: Fade-in)
import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  final String routeName;

  FadeRoute({required this.page, required this.routeName})
      : super(
          settings: RouteSettings(
              name: routeName), // Quan trọng để pushNamed hoạt động
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
