/// Base API service contract for network/database requests.
abstract class ApiService {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path, {dynamic data});
}
