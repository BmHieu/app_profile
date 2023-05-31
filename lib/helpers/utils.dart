import 'package:connectivity/connectivity.dart';
import 'package:dailycanhan/config/config.dart';
import 'package:dailycanhan/helpers/exceptions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static final Utils _singleton = Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();

  // only use this if reuse image for both dark & light theme
  // otherwise using getSvgPicture in Themes class
  static getSvgPicture(String name) => SvgPicture.asset('assets/$name.svg');

  bool isValidEmail(String email) {
    String p = r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  toast(dynamic str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: App.theme!.colors.neutral300,
        textColor: App.theme!.colors.black,
        fontSize: 14.0);
  }

  warningToast(dynamic str) {
    Fluttertoast.showToast(
        msg: str,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER,
        backgroundColor: App.theme!.colors.warning500,
        textColor: App.theme!.colors.black,
        fontSize: 14.0);
  }

  successToast(dynamic str) {
    Fluttertoast.showToast(
        msg: str,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER,
        backgroundColor: App.theme!.colors.success500,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  errorToast(dynamic str) {
    Fluttertoast.showToast(
        msg: str,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: App.theme!.colors.destructive500,
        textColor: Colors.black,
        fontSize: 14.0);
  }

  logError({Exception? exception, dynamic error, dynamic content}) {
    if (exception == null) {
      exception = Exception(error);
    }
    if (!ConfigApp.isProd() && content != null) print(content);
  }

  String localeCurrency(double money, BuildContext context,
      {required String symbol, int decimalDigits = 0, shorten = false}) {
    var currencyFormat = shorten
        ? NumberFormat.compactCurrency(locale: context.locale.toString(), decimalDigits: decimalDigits, symbol: symbol)
        : NumberFormat.currency(locale: context.locale.toString(), decimalDigits: decimalDigits, symbol: symbol);
    return currencyFormat.format(money);
  }

  String parseDatetime(DateTime dateTime, {String format = "HH:mm dd/MM/yyyy"}) {
    return DateFormat(format).format(dateTime);
  }

  String parseTime(DateTime dateTime) {
    return DateFormat("H:m").format(dateTime);
  }

  String parseDateUS(DateTime dateTime, {String format = "yyyy-MM-dd"}) {
    return DateFormat(format).format(dateTime);
  }

  String parseDateVN(DateTime dateTime, {String format = "dd/MM/yyyy"}) {
    return DateFormat(format).format(dateTime);
  }

  int parseDaysAgo(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration duration = now.difference(dateTime);
    return duration.inDays;
  }

  bool isEmptyString(String? str) {
    return str == null || str.isEmpty;
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  String getDoW(int dow) {
    return dow < 7 ? "Thứ ${dow + 1}" : "Chủ nhật";
  }

  Future<bool> noInternet() async {
    try {
      return await (Connectivity().checkConnectivity()) == ConnectivityResult.none;
    } catch (e) {
      utils.logError(content: e.toString());
      throw NoInternetException();
    }
  }

  DateTime toDateTime(String dateTimeStr) {
    try {
      return DateTime.parse(dateTimeStr);
    } catch (e) {
      utils.logError(content: e.toString());
      rethrow;
    }
  }

  bool isConfirmPassword(String? password, String? confirmPassword) {
    if (password != null && confirmPassword != null) {
      if (password == confirmPassword) {
        return true;
      }
    }
    return false;
  }

  bool isValidPassword(String? password) {
    if (password != null && password.isNotEmpty && password.length >= 6) return true;
    return false;
  }

  bool isValidPhoneNumber(String phone) {
    String p = r'([+]84|0[0-9])+([0-9]{8})\b';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(phone);
  }

  bool isValidBirthDay(String birthDate) {
    String p = r'\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(birthDate);
  }

  Map<String, dynamic> sortParams(Map<String, dynamic> params) {
    final sortedParams = <String, dynamic>{};
    final keys = params.keys.toList()..sort();
    for (String key in keys) {
      sortedParams[key] = params[key];
    }
    return sortedParams;
  }
}

final utils = Utils();
