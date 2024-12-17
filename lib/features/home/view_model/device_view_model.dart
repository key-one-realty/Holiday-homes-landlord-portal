import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/config/helpers/util_functions.dart';
import 'package:landlord_portal/features/home/model/device_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DeviceProvider extends ChangeNotifier {
  DeviceResponse? _deviceResponse;

  DeviceData? _deviceData;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String get deviceId {
    if (_deviceData != null) {
      return _deviceData!.id;
    } else {
      return "";
    }
  }

  String formatDate(DateTime date) {
    String pad(int n, [int width = 2]) => n.toString().padLeft(width, '0');

    String year = date.year.toString();
    String month = pad(date.month);
    String day = pad(date.day);
    String hours = pad(date.hour);
    String minutes = pad(date.minute);
    String seconds = pad(date.second);
    String milliseconds = pad(date.millisecond, 3);

    return '$year-$month-$day $hours:$minutes:$seconds.$milliseconds';
  }

  String detectAppPlatform() {
    if (Platform.isAndroid) {
      return "ANDROID";
    } else if (Platform.isIOS) {
      return "IOS";
    } else if (Platform.isWindows) {
      return "WINDOWS";
    } else if (Platform.isMacOS) {
      return "MACOS";
    } else {
      return "UNSUPPORTED";
    }
  }

  String getCurrentTime() {
    DateTime date = DateTime.now();

    String notifiedAt = formatDate(date);
    return notifiedAt;
  }

  Future<Map<String, String>?> getRequestHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");

    Map<String, String>? header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    return header;
  }

  Future<bool> registerDevice(String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool? notificationsAllowed = prefs.getBool("notifications_allowed");

      NotificationSettings settings = await messaging.getNotificationSettings();

      // prevent the device from calling the register API unnecessarily
      if ((notificationsAllowed != null && notificationsAllowed) ||
          settings.authorizationStatus != AuthorizationStatus.authorized) {
        customDebugPrint("Device already registered");
        return false;
      }

      Uri url = Uri.parse(registerDeviceAPI);

      String? fcmToken = await messaging.getToken();

      bool notifyDevice = true;

      DateTime date = DateTime.now();

      String notifiedAt = formatDate(date);

      String appPlatform = detectAppPlatform();

      Object? payload = jsonEncode(<String, dynamic>{
        "fcm_token": fcmToken,
        "user_id": userId,
        "notify_device": notifyDevice,
        "platform": appPlatform,
        "notified_at": notifiedAt
      });

      final response = await http.post(
        url,
        headers: await getRequestHeader(),
        body: payload,
      );

      final data = jsonDecode(response.body);
      customDebugPrint('$data');

      if (response.statusCode == 200) {
        _deviceResponse = DeviceResponse.fromJson(data);
        _deviceData = _deviceResponse!.data;

        // indicate that the device has already been registered in the DB
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          prefs.setBool("notifications_allowed", true);
          prefs.setString("device_id", _deviceData!.id);
        } else {
          prefs.setBool("notifications_allowed", false);
        }
        notifyListeners();
        return _deviceResponse!.success;
      } else {
        throw Exception(data["message"]);
      }
    } catch (e) {
      customDebugPrint("Error registering device: $e");
      return false;
    }
  }

  Future<bool> deviceReceivedNotification() async {
    try {
      Uri url = Uri.parse(deviceReceivedNotificationAPI);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? prefDeviceId = prefs.getString("device_id");

      if (prefDeviceId == null || prefDeviceId == "") {
        customDebugPrint("no device id");
        return false;
      }

      Object? patchPayload = jsonEncode(<String, dynamic>{
        "notified_at": getCurrentTime(),
        "device_id": prefDeviceId,
      });

      final response = await http.patch(
        url,
        headers: await getRequestHeader(),
        body: patchPayload,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(data["message"]);
      }
    } catch (e) {
      customDebugPrint("Error updating device: $e");
      return false;
    }
  }
}
