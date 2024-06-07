import 'package:flutter_dotenv/flutter_dotenv.dart';

String? getEnvironmentalVariable(String key) {
  return String.fromEnvironment(key, defaultValue: dotenv.env[key] ?? "");
}

String? baseApi = getEnvironmentalVariable("BASE_API_URL");

String login = '$baseApi/login';

String getUserAPI = '$baseApi/user';

String getUserPropertiesAPI = '$baseApi/property/all';

String getPropertyDetailsAPI = '$baseApi/property/details';

String getLandlordReportAPI = '$baseApi/user/report';
