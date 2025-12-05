// 自定义异常类，用于处理网络请求异常
import 'package:dio/dio.dart';

class NetException implements Exception {
  final String message;
  final int? code;

  NetException(this.message, [this.code]);

  @override
  String toString() => "$message (code: $code)";

  // 静态工厂方法：处理 Dio 异常
  factory NetException.create(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return NetException("连接超时", -1);
        case DioExceptionType.sendTimeout:
          return NetException("请求超时", -1);
        case DioExceptionType.receiveTimeout:
          return NetException("响应超时", -1);
        case DioExceptionType.badResponse:
          int? statusCode = error.response?.statusCode;
          return NetException(_handleHttpError(statusCode), statusCode);
        case DioExceptionType.cancel:
          return NetException("请求取消", -2);
        default:
          return NetException("网络异常，请检查网络", -3);
      }
    } else if (error is NetException) {
      return error;
    } else {
      return NetException("未知错误: $error", -99);
    }
  }

  static String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400: return "请求语法错误";
      case 401: return "没有权限";
      case 403: return "服务器拒绝执行";
      case 404: return "无法连接服务器";
      case 500: return "服务器内部错误";
      case 502: return "无效的请求";
      case 503: return "服务器挂了";
      default: return "未知网络错误";
    }
  }
}