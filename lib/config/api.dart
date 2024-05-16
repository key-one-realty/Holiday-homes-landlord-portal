import 'package:flutter_dotenv/flutter_dotenv.dart';

String? baseApi = dotenv.env["BASE_API_URL"];

String login = '$baseApi/login';

String getUserPropertiesAPI = '$baseApi/property/all';

String getPropertyDetailsAPI = '$baseApi/property/details';
