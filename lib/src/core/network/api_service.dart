import 'network_client.dart';

class ApiService {
  static final ApiService _service = ApiService._internal();

  factory ApiService() {
    return _service;
  }

  ApiService._internal();

  NetworkClient networkClient = NetworkClient();
  String? bearerToken;
}
