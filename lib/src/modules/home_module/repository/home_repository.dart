import 'package:dio/dio.dart';
import 'package:tv_project/main.dart';

import '../../../core/app_apis.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_client.dart';

class HomeRepository {
  NetworkClient networkClient = ApiService().networkClient;

  Future<Response> getTokenTypes(Map<String, Object> params) async {
    return await networkClient.post(AppApis.getTokenTypes, params);
  }

  Future<Response> generateToken(Map<String, dynamic> params) async {
    return await networkClient.post(AppApis.generateToken, params);
  }

  Future<Response> getRoomAllTokens(Map<String, dynamic> params) async {
    return await networkClient.post(
      AppApis.getRoomAllTokens,
      params,
      overrideToken: (prefs.getString('token')),
    );
  }
}
