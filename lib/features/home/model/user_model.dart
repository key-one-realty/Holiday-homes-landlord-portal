class UserResponse {
  bool success;
  User user;

  UserResponse({
    required this.success,
    required this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  String id;
  String name;
  String email;
  String phoneNumber;
  dynamic emailVerifiedAt;
  String lastLoggedIn;
  String createdAt;
  String updatedAt;
  String oneCId;
  dynamic ownerId;
  double closingBalance;
  final int showBookingPlatform;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.lastLoggedIn,
    required this.createdAt,
    required this.updatedAt,
    required this.oneCId,
    required this.ownerId,
    required this.closingBalance,
    required this.showBookingPlatform,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      closingBalance: json['closing_balance'].toDouble(),
      showBookingPlatform: json['show_booking_platform'],
    );
  }
}
