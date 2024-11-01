import 'package:flutter_dotenv/flutter_dotenv.dart';

String? getEnvironmentalVariable(String key) {
  return String.fromEnvironment(key, defaultValue: dotenv.env[key] ?? "");
}

String? baseApi = getEnvironmentalVariable("BASE_API_URL");

String verifyAccessTokenAPI = '$baseApi/validate-token';

String login = '$baseApi/login';

String getUserAPI = '$baseApi/user';

String getUserPropertiesAPI = '$baseApi/property/all';

String getPropertyDetailsAPI = '$baseApi/property/details';

String getLandlordReportAPI = '$baseApi/user/report';

String getUserStatements = '$baseApi/statements/all';

String registerDeviceAPI = '$baseApi/devices/register';

String deviceReceivedNotificationAPI = '$baseApi/devices/received-notification';
