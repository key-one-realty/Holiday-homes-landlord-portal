import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/config/helpers/util_functions.dart';
import 'package:landlord_portal/features/statements/model/statement_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StatementProvider extends ChangeNotifier {
  StatementsResponse? _statementsResponse;

  List<Statement>? _statements;

  String _pdfLink = "";

  String get pdfLink => _pdfLink;

  set setPDFLink(String pdfLink) {
    _pdfLink = pdfLink;
    notifyListeners();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  bool isSuccess = false;

  set setIsLoading(bool isLoadingValue) {
    _isLoading = isLoadingValue;
    notifyListeners();
  }

  List<Statement> get statements {
    if (_statements != null) {
      if (_statements!.isNotEmpty) {
        return _statements!;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<bool> getStatements(String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("accessToken");
      Map<String, String>? header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      Uri url = Uri.parse('$getUserStatements/$userId');

      final response = await http.get(url, headers: header);
      //access the response
      final data = jsonDecode(response.body);
      customDebugPrint('$data');

      if (response.statusCode == 200) {
        _statementsResponse = StatementsResponse.fromJson(data);
        _statements = _statementsResponse?.statements;

        setIsLoading = false;
        notifyListeners();
        return _statementsResponse!.success;
      } else {
        throw Exception(data["message"]);
      }
    } catch (e) {
      setIsLoading = false;
      customDebugPrint('$e');
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return false;
  }
}
