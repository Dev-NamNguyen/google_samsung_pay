import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_samsung_pay/features/auth/data/models/temp_user.model.dart';
import 'package:google_samsung_pay/features/auth/data/models/user.model.dart';

class SessionManager {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';

  static SessionManager? _instance;
  static SharedPreferences? _prefs;

  SessionManager._internal();

  static SessionManager get instance {
    _instance ??= SessionManager._internal();
    return _instance!;
  }

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save user session
  Future<void> saveSession({
    required String token,
    required String refreshToken,
    required UserModel user,
    required DateTime expiryDate,
  }) async {
    await _prefs?.setString(_tokenKey, token);
    await _prefs?.setString(_refreshTokenKey, refreshToken);
    await _prefs?.setString(_userKey, jsonEncode(user.toJson()));
    await _prefs?.setBool(_isLoggedInKey, true);
    await _prefs?.setString(_tokenExpiryKey, expiryDate.toIso8601String());

    print('✅ Session saved successfully');

    printSessionInfo();
  }

  Future<bool> saveTempUser(TempUserModel user) async {
    if (user.uid == null || user.uid!.isEmpty) {
      print('❌ Cannot save TempUserModel without uid');
      return false;
    }
    await _prefs?.setString('temp_user', jsonEncode(user.toJson()));

    print('✅ Temporary user saved successfully');
    return true;
  }

  TempUserModel? get tempUser => _getTempUser();
  TempUserModel? _getTempUser() {
    final tempUserJson = _prefs?.getString('temp_user');
    if (tempUserJson != null) {
      try {
        return TempUserModel.fromJson(jsonDecode(tempUserJson));
      } catch (e) {
        print('❌ Error parsing temporary user data: $e');
        return null;
      }
    }
    return null;
  }

  // Get current token
  String? get token {
    return _prefs?.getString(_tokenKey);
  }

  // Get refresh token
  String? get refreshToken {
    return _prefs?.getString(_refreshTokenKey);
  }

  // Get current user
  UserModel? get currentUser {
    final userJson = _prefs?.getString(_userKey);
    if (userJson != null) {
      try {
        return UserModel.fromJson(jsonDecode(userJson));
      } catch (e) {
        print('❌ Error parsing user data: $e');
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  bool get isLoggedIn {
    print("namnguyendevv: Checking if user is logged in");
    final loggedIn = _prefs?.getBool(_isLoggedInKey) ?? false;
    print("🚀 ~ loggedIn: $loggedIn");
    if (loggedIn) {
      // Check if token is expired
      final expiryString = _prefs?.getString(_tokenExpiryKey);
      if (expiryString != null) {
        try {
          final expiryDate = DateTime.parse(expiryString);
          if (DateTime.now().isAfter(expiryDate)) {
            print('⚠️ Token expired, logging out user');
            clearSession();
            return false;
          }
        } catch (e) {
          print('❌ Error parsing token expiry: $e');
          clearSession();
          return false;
        }
      }
    }
    return loggedIn;
  }

  // Get token expiry date
  DateTime? get tokenExpiry {
    final expiryString = _prefs?.getString(_tokenExpiryKey);
    if (expiryString != null) {
      try {
        return DateTime.parse(expiryString);
      } catch (e) {
        print('❌ Error parsing token expiry: $e');
        return null;
      }
    }
    return null;
  }

  // Check if token is expired
  bool get isTokenExpired {
    final expiry = tokenExpiry;
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  // Update user data
  Future<void> updateUser(UserModel user) async {
    await _prefs?.setString(_userKey, jsonEncode(user.toJson()));
    print('✅ User data updated successfully');
  }

  // Update token
  Future<void> updateToken({
    required String newToken,
    required String newRefreshToken,
    required DateTime newExpiryDate,
  }) async {
    await _prefs?.setString(_tokenKey, newToken);
    await _prefs?.setString(_refreshTokenKey, newRefreshToken);
    await _prefs?.setString(_tokenExpiryKey, newExpiryDate.toIso8601String());
    print('✅ Token updated successfully');
  }

  // Clear session (logout)
  Future<void> clearSession() async {
    await _prefs?.remove(_tokenKey);
    await _prefs?.remove(_refreshTokenKey);
    await _prefs?.remove(_userKey);
    await _prefs?.remove(_isLoggedInKey);
    await _prefs?.remove(_tokenExpiryKey);
    print('✅ Session cleared successfully');
  }

  // Get session info for debugging
  Map<String, dynamic> get sessionInfo {
    return {
      'isLoggedIn': isLoggedIn,
      'hasToken': token != null,
      'hasUser': currentUser != null,
      'tokenExpiry': tokenExpiry?.toIso8601String(),
      'isTokenExpired': isTokenExpired,
    };
  }

  // Print session info for debugging
  void printSessionInfo() {
    print('🔍 Session Info:');
    print('   Is Logged In: ${isLoggedIn}');
    print('   Has Token: ${token != null}');
    print('   Has User: ${currentUser != null}');
    print('   Token Expiry: ${tokenExpiry?.toIso8601String()}');
    print('   Is Token Expired: ${isTokenExpired}');
    if (currentUser != null) {
      print('   User: ${currentUser!.displayName} (${currentUser!.email})');
    }
  }
}
