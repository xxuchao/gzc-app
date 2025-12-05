import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CustomLogInterceptor {
  /// 获取配置好的日志拦截器实例
  static Interceptor get instance {
    return PrettyDioLogger(
      requestHeader: true,  // 打印请求头
      requestBody: true,    // 打印请求体
      responseHeader: false,// 响应头通常不打印，太长
      responseBody: true,   // 打印响应内容
      error: true,          // 打印错误信息
      compact: true,        // 是否压缩输出 (减少空行)
      maxWidth: 90,         // 每行最大宽度
      // logPrint: (obj) => print("网络日志: $obj"), // 如果需要自定义打印方式
    );
  }
}