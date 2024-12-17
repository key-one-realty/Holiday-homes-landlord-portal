import 'package:flutter/material.dart';

class SharedComponentModel extends ChangeNotifier {
  bool _obscureLoginPasswordField = true;

  bool get obscureLoginPasswordField => _obscureLoginPasswordField;

  void toggleObscureLoginPasswordField() {
    _obscureLoginPasswordField = !_obscureLoginPasswordField;
    notifyListeners();
  }
}
