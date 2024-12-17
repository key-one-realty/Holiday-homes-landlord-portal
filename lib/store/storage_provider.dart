import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends ChangeNotifier {
  late SharedPreferences prefs;

  void getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}
