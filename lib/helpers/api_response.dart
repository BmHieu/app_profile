import 'dart:io';

import 'package:dailycanhan/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

Future<APIResponse> handleResponse(Future<Response> request, {required Function(String) customTr}) async {
  try {
    Response response = await request;
    if (response == null) return APIResponse(success: false);

    var data = response.data;
    if (response.headers != null && response.headers.value('content-type') == 'text/csv') {
      return APIResponse(success: true, data: data);
    }
    var success = [HttpStatus.ok, HttpStatus.created, HttpStatus.noContent].contains(response.statusCode);
    return APIResponse(success: success, data: data);
  } catch (error) {
    rethrow;
  }
}

class APIResponse {
  final bool success;
  final dynamic data;

  APIResponse({this.success = false, this.data});
}

abstract class APIException implements DioError {
  @override
  var error;

  @override
  late RequestOptions requestOptions;

  @override
  Response? response;

  @override
  StackTrace? stackTrace;

  @override
  late DioErrorType type;

  @override
  String get message => throw UnimplementedError();
}

class APIUnauthorizedException extends APIException {
  @override
  String get message => LocaleKeys.auth_unauthenticated.tr();
}

class APINoPermissionException extends APIException {
  @override
  String get message => LocaleKeys.error_no_permission.tr();
}

class APIBadRequestException extends APIException {
  @override
  String get message => LocaleKeys.error_bad_request.tr();
}

class APIUnknownErrorException extends APIException {
  @override
  String get message => LocaleKeys.error_unknown_error.tr();
}

class APINotFoundException extends APIException {
  @override
  String get message => LocaleKeys.error_cannot_find_data.tr();
}

class ConnectionTimeoutException extends APIException {
  @override
  String get message => LocaleKeys.error_connection_timeout.tr();
}
