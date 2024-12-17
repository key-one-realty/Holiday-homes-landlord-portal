class DeviceResponse {
  bool success;
  DeviceData data;

  DeviceResponse({
    required this.success,
    required this.data,
  });

  factory DeviceResponse.fromJson(Map<String, dynamic> json) {
    return DeviceResponse(
      success: json['success'],
      data: DeviceData.fromJson(json['data']),
    );
  }
}

class DeviceData {
  String fcmToken;
  String platform;
  DateTime notifiedAt;
  bool notifyDevice;
  String userId;
  String id;
  DateTime updatedAt;
  DateTime createdAt;

  DeviceData({
    required this.fcmToken,
    required this.platform,
    required this.notifiedAt,
    required this.notifyDevice,
    required this.userId,
    required this.id,
    required this.updatedAt,
    required this.createdAt,
  });

  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      fcmToken: json['fcm_token'],
      platform: json['platform'],
      notifiedAt: DateTime.parse(json['notified_at']),
      notifyDevice: json['notify_device'],
      userId: json['user_id'],
      id: json['id'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
