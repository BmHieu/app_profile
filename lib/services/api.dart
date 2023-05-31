import 'dart:io';

import 'package:dailycanhan/config/config.dart';
import 'package:dailycanhan/data/local/secure_storage.dart';
import 'package:dailycanhan/helpers/api_response.dart';
import 'package:dailycanhan/helpers/utils.dart';
import 'package:dio/dio.dart';

abstract class BaseAPI {
  Dio? _dio;
  List<Function> _onErrorCallbacks = [];

  Future<Response> signUp({String? name, String? email, String? password, String? confirmPassword, String? phone});
  Future<Response> authenticate({String? username, String? password});
  Future<Response> getProfile();

  _logging() {
    return InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      print(
          "DIO - REQUEST: [${options.method}] ${options.path}} \nquery:${options.queryParameters}\nbody:${options.data}");
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) async {
      print("DIO - RESPONSE: [${response.requestOptions.method}] ${response.requestOptions.path} "
          "${response.statusCode} [OK]\n"
          "query:${response.requestOptions.queryParameters}\n"
          "body:${response.requestOptions.data}\n"
          "response:${response.data}");
      return handler.next(response);
    }, onError: (DioError e, ErrorInterceptorHandler handler) async {
      utils.logError(
          exception: Exception(e),
          content:
              "DIO - ERROR: ${e.requestOptions.path}\ndata: ${e.requestOptions.data}\nresponse:${e.response?.data}");
      try {
        notifyErrorCallbacks(e);
      } catch (error) {
        e = error as DioError;
      }
      return handler.next(e);
    });
  }

  void addErrorInterceptor(callback) {
    _onErrorCallbacks.add(callback);
  }

  void notifyErrorCallbacks(DioError error) {
    _onErrorCallbacks.forEach((callback) {
      callback(error);
      if (error.type == DioErrorType.connectTimeout) {
        throw ConnectionTimeoutException();
      }

      if (error is DioError) {
        switch (error.response?.statusCode) {
          case HttpStatus.forbidden:
            throw APINoPermissionException();
          case HttpStatus.unauthorized:
            secureStorage.removeAccessToken();
            throw APIUnauthorizedException();
          case HttpStatus.badRequest:
            throw APIBadRequestException();
          case HttpStatus.internalServerError:
            throw APIUnknownErrorException();
          case HttpStatus.notFound:
            throw APINotFoundException();
        }
      }
    });
  }

  Future<void> _addAuthHeader() async {
    var accessToken = await secureStorage.getAccessToken();
    _dio!.options.headers['Authorization'] = "Bearer $accessToken";
  }
}

class API extends BaseAPI {
  static final API _singleton = API._internal();

  factory API() {
    return _singleton;
  }

  API._internal() {
    _dio = Dio();
    _dio!.options.baseUrl = ConfigApp.baseURL;
    _dio!.options.connectTimeout = 50000; //5s
    _dio!.options.receiveTimeout = 50000;
    _dio!.options.responseType = ResponseType.json;

    _dio!.interceptors.add(_logging());
  }

  @override
  Future<Response> signUp(
      {String? name, String? email, String? password, String? confirmPassword, String? phone}) async {
    return await _dio!.post("/users/sign-up/",
        data: {"name": name, "email": email, "password": password, "confirmPassword": confirmPassword, "phone": phone});
  }

  @override
  Future<Response> authenticate({String? username, String? password}) async {
    return await _dio!.post("/auth/sign-in/", data: {
      "username": username,
      "password": password,
    });
  }

  @override
  Future<Response> getProfile() async {
    await _addAuthHeader();
    return await _dio!.get("/users/profile/");
  }
}

final api = API();
