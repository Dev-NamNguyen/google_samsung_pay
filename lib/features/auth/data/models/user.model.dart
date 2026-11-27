class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? phoneNumber;
  final String role;
  final bool isActive;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? avatar;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.phoneNumber,
    required this.role,
    required this.isActive,
    this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      displayName: json['displayName']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString(),
      role: json['role']?.toString() ?? 'user',
      isActive: json['isActive'] ?? true,
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      avatar: json['avatar']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'role': role,
      'isActive': isActive,
      'lastLogin': lastLogin?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'avatar': avatar,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? phoneNumber,
    String? role,
    bool? isActive,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avatar,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      avatar: avatar ?? this.avatar,
    );
  }
}
