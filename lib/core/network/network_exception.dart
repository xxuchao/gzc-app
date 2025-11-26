/// 自定义网络异常类
class NetworkException implements Exception {
  final String message;
  final int? code;
  final NetworkErrorType type;

  NetworkException(this.message, this.type, {this.code});

  /// 超时
  factory NetworkException.timeout(String message) {
    return NetworkException(message, NetworkErrorType.timeout);
  }

  /// 网络错误
  factory NetworkException.networkError(String message) {
    return NetworkException(message, NetworkErrorType.networkError);
  }

  /// HTTP错误
  factory NetworkException.httpError(int statusCode, String message) {
    return NetworkException(message, NetworkErrorType.httpError, code: statusCode);
  }

  /// 业务错误
  factory NetworkException.businessError(int code, String message) {
    return NetworkException(message, NetworkErrorType.businessError, code: code);
  }

  /// Token过期
  factory NetworkException.tokenExpired(String message) {
    return NetworkException(message, NetworkErrorType.tokenExpired);
  }

  /// 无权限访问
  factory NetworkException.forbidden(String message) {
    return NetworkException(message, NetworkErrorType.forbidden);
  }

  /// 资源不存在
  factory NetworkException.notFound(String message) {
    return NetworkException(message, NetworkErrorType.notFound);
  }

  /// 服务器错误
  factory NetworkException.serverError(String message) {
    return NetworkException(message, NetworkErrorType.serverError);
  }

  /// 证书错误
  factory NetworkException.badCertificate(String message) {
    return NetworkException(message, NetworkErrorType.badCertificate);
  }

  /// 请求被取消
  factory NetworkException.cancel(String message) {
    return NetworkException(message, NetworkErrorType.cancel);
  }

  /// 未知错误
  factory NetworkException.unknown(String message) {
    return NetworkException(message, NetworkErrorType.unknown);
  }

  @override
  String toString() {
    return 'NetworkException{message: $message, code: $code, type: $type}';
  }
}

/// 网络错误类型枚举
enum NetworkErrorType {
  timeout,         // 超时
  networkError,    // 网络错误
  httpError,       // HTTP错误
  businessError,   // 业务错误
  tokenExpired,    // Token过期
  forbidden,       // 无权限
  notFound,        // 资源不存在
  serverError,     // 服务器错误
  badCertificate,  // 证书错误
  cancel,          // 请求被取消
  unknown          // 未知错误
}