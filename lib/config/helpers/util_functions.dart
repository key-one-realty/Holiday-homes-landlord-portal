import 'package:flutter/foundation.dart';

// Handle Debug Printing as specified by best practices
void customDebugPrint(String data) {
  if (kDebugMode) {
    debugPrint(data);
  }
}
