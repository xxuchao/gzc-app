import 'package:dio/dio.dart';

import 'network_client.dart';

class NetworkInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 添加默认请求头
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    
    // 添加认证令牌（如果存在）
    final authToken = NetworkClient().config.authToken;
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    
    // 添加API Key（如果存在）
    final apiKey = NetworkClient().config.apiKey;
    if (apiKey != null && apiKey.isNotEmpty) {
      options.headers['X-API-Key'] = apiKey;
    }
    
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 可以在这里对响应做统一处理
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 可以在这里对错误做统一处理
    super.onError(err, handler);
  }
}