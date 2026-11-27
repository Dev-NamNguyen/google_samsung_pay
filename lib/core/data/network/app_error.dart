import 'package:google_samsung_pay/core/data/app_exceptions.dart';

class AppError implements AppExceptions {
  int? status;
  String? message;

  AppError(this.message, {this.status});

  AppError.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = json['message'] ?? '';
      // status = json['status'] ?? 0;
    }
  }
}
