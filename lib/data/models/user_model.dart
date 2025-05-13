import '../../domain/entities/user.dart';

class UserModel {
  final User user;

  UserModel({
    required String id,
    required String name,
    required String email,
    String? profileImage,
    String? phone,
    bool isEmailVerified = false,
    List<String> weddingIds = const [],
    DateTime? lastLogin,
    Map<String, dynamic> preferences = const {},
  }) : user = User(
          id: id,
          name: name,
          email: email,
          profileImage: profileImage,
          phone: phone,
          isEmailVerified: isEmailVerified,
          weddingIds: weddingIds,
          lastLogin: lastLogin,
          preferences: preferences,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String?,
      phone: json['phone'] as String?,
      isEmailVerified: json['is_email_verified'] as bool? ?? false,
      weddingIds: (json['wedding_ids'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login'] as String) : null,
      preferences: json['preferences'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'profile_image': user.profileImage,
      'phone': user.phone,
      'is_email_verified': user.isEmailVerified,
      'wedding_ids': user.weddingIds,
      'last_login': user.lastLogin?.toIso8601String(),
      'preferences': user.preferences,
    };
  }

  // Delegate getters to the user instance
  String get id => user.id;
  String get name => user.name;
  String get email => user.email;
  String? get profileImage => user.profileImage;
  String? get phone => user.phone;
  bool get isEmailVerified => user.isEmailVerified;
  List<String> get weddingIds => user.weddingIds;
  DateTime? get lastLogin => user.lastLogin;
  Map<String, dynamic> get preferences => user.preferences;
}
