class AuthUserModel {
  final bool success;
  final UserModel user;
  final String accessToken;

  AuthUserModel({
    required this.success,
    required this.user,
    required this.accessToken,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      success: json['success'],
      user: UserModel.fromJson(json['user']),
      accessToken: json['accessToken'],
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? emailVerifiedAt;
  final String lastLoggedIn;
  final String createdAt;
  final String updatedAt;
  final String oneCId;
  final int? ownerId;
  final double closingBalance;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.emailVerifiedAt,
    required this.lastLoggedIn,
    required this.createdAt,
    required this.updatedAt,
    required this.oneCId,
    this.ownerId,
    required this.closingBalance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      emailVerifiedAt: json['email_verified_at'],
      lastLoggedIn: json['last_logged_in'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      oneCId: json['one_c_id'],
      ownerId: json['owner_id'],
      closingBalance: double.parse(json['closing_balance']),
    );
  }
}
