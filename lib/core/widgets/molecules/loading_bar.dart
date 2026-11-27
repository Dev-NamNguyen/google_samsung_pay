import 'dart:math';
import 'package:flutter/material.dart';

class LoadingBar extends StatefulWidget {
  const LoadingBar({super.key});

  @override
  State<LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<LoadingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        // Góc xoay từ 0 đến 2pi (360 độ)
        double angle = _controller.value * 2 * pi;

        // Tính scale dựa trên cos(angle) -> phóng to ở 0 và 180 độ, nhỏ ở 90 và 270 độ
        double scale = 1 + 0.1 * cos(angle);

        return Transform.rotate(
          angle: angle,
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFCCFF00), Color(0xFF00B2FF)],
          ),
        ),
        child: const Icon(Icons.sports_tennis, color: Colors.black, size: 28),
      ),
    );
  }
}
