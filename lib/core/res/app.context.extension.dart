import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/resources.dart';

extension AppContextExtension on BuildContext {
  Resources get resources => Resources.of(this);
}
