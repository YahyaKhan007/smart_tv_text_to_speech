import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../../../main.dart';
import '../error/exceptions.dart';
import '../utills/messagee_service.dart';
import 'fetch_jwt.dart';

class NetworkClient {
  Dio _dio = Dio();

  void _handleSessionExpired() async {
    // Optionally show message

    // AuthController authController = Get.find();
    // await authController.logout();
    MessageService.showSnackBar(message: "Token Expired! Please login", isSuccess: false);
  }

  NetworkClient() {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 30),
      //  baseUrl: baseUrl,
      maxRedirects: 0,
      //maxRedirects: 0,
      // followRedirects: false,
    );
    _dio = Dio(baseOptions);
    // adding logging interceptor.

    _dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        error: true,
        request: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
      alice.getDioInterceptor(),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await prefs.getString('token') ?? '';
          final correctToken = token.replaceAll('+', ' ');
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint('✅ Sending token: Bearer $correctToken');
          } else {
            print('❌ No token found');
          }

          return handler.next(options);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          if (e.response?.statusCode == 401) {
            // Log out the user
            _handleSessionExpired();
          }
          return handler.next(e);
        },
      ),
    ]);
  }

  Future<Response> get(String url, Map<String, dynamic> params) async {
    try {
      Response response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json),
      );
      debugPrint("Encrypted Response is : $response");

      // If your API always wraps payload like: { EncreptedData: "<base64>" }
      final decryptedResponse = decodeBase64Plaintext(response.data['EncreptedData']);

      final Map<String, dynamic> decryptedJson = jsonDecode(decryptedResponse);

      debugPrint("PRINTING DATA TYPE");
      debugPrint("decoded Response DATATYPE IS  : ${decryptedJson.runtimeType}");

      // Put decrypted JSON back into response.data and return the Response
      response.data = decryptedJson;
      return response;
    } on DioException catch (exception) {
      throw RemoteException(dioError: exception);
    }
  }

  Future<Response> post(
    String url,
    dynamic params, {
    ResponseType responseType = ResponseType.json,
    String? overrideToken, // Optional token
  }) async {
    try {
      // final authController = Get.find<AuthController>();
      final headers = <String, dynamic>{};

      if (overrideToken != null && overrideToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $overrideToken';
      }

      Response response = await _dio.post(
        url,
        data: params,
        options: Options(responseType: responseType, headers: headers.isNotEmpty ? headers : null),
        onSendProgress: (int sent, int total) {
          // authController.uploadProgress.value = (sent / total) * 100;
          debugPrint('THE SENDING AMOUNT :: $sent $total');
        },
      );

      debugPrint("Encrypted Response is : $response");

      // If your API always wraps payload like: { EncreptedData: "<base64>" }
      final decryptedResponse = decodeBase64Plaintext(response.data['EncreptedData']);

      final Map<String, dynamic> decryptedJson = jsonDecode(decryptedResponse);

      debugPrint("PRINTING DATA TYPE");
      debugPrint("decoded Response DATATYPE IS  : ${decryptedJson.runtimeType}");

      // Put decrypted JSON back into response.data and return the Response
      response.data = decryptedJson;
      return response;
    } on DioException catch (exception) {
      if (exception.response?.statusCode == 401) {
        await fetchAndStoreJwtToken();
      }
      debugPrint("CAME TO ERRRO WHILE DECRYPTED ");
      throw RemoteException(dioError: exception);
    }
  }

  Future<Response> put(String url, Map<String, Object> params, {String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {};

      if (token != null) map.addAll({"Authorization": "Bearer $token"});
      response = await _dio.put(
        url,
        data: params,
        options: Options(responseType: ResponseType.json, headers: map),
      );
    } on DioException catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }

  Future<Response> delete(String url, dynamic params, {String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {};

      if (token != null) map.addAll({"Authorization": "Bearer $token"});
      response = await _dio.delete(
        url,
        data: params,
        options: Options(responseType: ResponseType.json, headers: map),
      );
    } on DioException catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }

  Future<Response> download(
    String url,
    String pathName,
    void Function(int, int)? onReceiveProgress,
  ) async {
    Response response;
    try {
      response = await _dio.download(url, pathName, onReceiveProgress: onReceiveProgress);
    } on DioException catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }
}

class ConnectionStatusModel {
  Response? response;
  bool connected;

  ConnectionStatusModel({this.response, required this.connected});
}

String decodeBase64Plaintext(String base64Text) {
  final bytes = base64.decode(base64Text);
  return utf8.decode(bytes);
}
