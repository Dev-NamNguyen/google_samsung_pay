import 'package:flutter/material.dart';
import 'package:google_samsung_pay/core/res/colors/colors.app.dart';
import 'package:google_samsung_pay/core/res/colors/colors.base.dart';
import 'package:google_samsung_pay/core/res/dimensions/dimensions.app.dart';
import 'package:google_samsung_pay/core/res/dimensions/dimensions.base.dart';

class Resources {
  final BuildContext context;
  Resources(this.context);

  ColorsBase get colors => ColorsApp();
  DimensionsBase get dimensions => DimensionsApp();

  static Resources of(BuildContext context) {
    return Resources(context);
  }
}
