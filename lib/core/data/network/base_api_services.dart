abstract class BaseApiServices {
  Future<dynamic> getApiResponse(String url, {Map<String, String>? queries});
  Future<dynamic> postApiResponse(String url, dynamic data,
      {Map<String, String>? queries});
  Future<dynamic> putApiResponse(String url,
      {dynamic data, Map<String, String>? queries});
  Future<dynamic> deleteApiResponse(String url);
}
