import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocaleBase {
  late Map<String, dynamic> _data;
  late String _path;
  Future<void> load(String path) async {
    _path = path;
    final strJson = await rootBundle.loadString(path);
    _data = jsonDecode(strJson);
    initAll();
  }
  
  Map<String, String> getData(String group) {
    return Map<String, String>.from(_data[group]);
  }

  String getPath() => _path;

  late Localeerror _error;
  Localeerror get error => _error;
  late Localecommon _common;
  Localecommon get common => _common;
  late Localeauth _auth;
  Localeauth get auth => _auth;

  void initAll() {
    _error = Localeerror(Map<String, String>.from(_data['error']));
    _common = Localecommon(Map<String, String>.from(_data['common']));
    _auth = Localeauth(Map<String, String>.from(_data['auth']));
  }
}

class Localeerror {
  late final Map<String, String> _data;
  Localeerror(this._data);

  String getByKey(String key) {
    return _data[key]!;
  }

  String get setup_db_failed => _data["setup_db_failed"]!;
  String get no_internet_connection => _data["no_internet_connection"]!;
  String get invalid_report_type => _data["invalid_report_type"]!;
  String get no_permission => _data["no_permission"]!;
  String get bad_request => _data["bad_request"]!;
  String get unknown_error => _data["unknown_error"]!;
  String get cannot_find_data => _data["cannot_find_data"]!;
  String get connection_timeout => _data["connection_timeout"]!;
}

class Localecommon {
  late final Map<String, String> _data;
  Localecommon(this._data);

  String getByKey(String key) {
    return _data[key]!;
  }

  String get back => _data["back"]!;
}

class Localeauth {
  late final Map<String, String> _data;
  Localeauth(this._data);

  String getByKey(String key) {
    return _data[key]!;
  }

  String get unauthenticated => _data["unauthenticated"]!;
}

