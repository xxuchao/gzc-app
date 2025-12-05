import 'package:dio/dio.dart';
import "net_config.dart" show HttpKeys;

// 如果需要处理 Token 自动刷新，继承 QueuedInterceptor
// 如果不需要刷新逻辑，继承 Interceptor 即可
class AuthInterceptor extends QueuedInterceptor {
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 检查是否需要跳过 AuthInterceptor
    final shouldSkipAuth = options.extra[HttpKeys.skipAuthHeader] == true;
    if (shouldSkipAuth) {
      return super.onRequest(options, handler);
    }
    
    // 1. 获取本地 Token (示例)
    const String? accessToken = "YOUR_TOKEN"; // 实际应从 SharedPreferences/GetStorage 获取
    // 2. 注入 Token
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    // 3. 注入其他通用 Header (例如语言、版本号)
    options.headers['Language'] = 'zh-CN';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 可以在这里统一处理业务状态码，例如后端返回 200，但 data 里 code 是 error
    // if (response.data['code'] == 401) { ... }
    
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 统一错误处理逻辑 (例如 Token 失效拦截)
    // 如果需要刷新 Token，请参考上一次回答中的逻辑
    
    print('AuthInterceptor 捕获错误: ${err.message}');
    
    super.onError(err, handler);
  }
}