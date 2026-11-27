import 'package:flutter/material.dart';

class NoSwipeMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoSwipeMaterialPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  bool get popGestureEnabled => false;
}
