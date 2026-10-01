abstract class BaseApiServices {
  Future<dynamic> getApi(String url, {bool requiresAuth = true});
  Future<dynamic> postApi(dynamic data, String url, {bool requiresAuth = false});
  Future<dynamic> patchApi(dynamic data, String url);
}