import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'network_config.dart';
import 'network_exception.dart';
import 'network_interceptors.dart';

class NetworkClient {
  static final NetworkClient _instance = NetworkClient._internal();

  factory NetworkClient() => _instance;

  NetworkClient._internal();

  late Dio _dio;
  late NetworkConfig _config;

  /// 初始化网络客户端
  void init({
    required NetworkConfig config,
    List<Interceptor>? interceptors,
  }) {
    _config = config;
    _dio = Dio();
    
    // 设置基础配置
    _dio.options = BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );

    // 添加默认拦截器
    _dio.interceptors.add(NetworkInterceptors());

    // 添加自定义拦截器
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }

    // 在调试模式下添加日志拦截器
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }
  }

  /// GET 请求
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST 请求
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT 请求
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE 请求
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 下载文件
  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options,
      );
      
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 处理响应数据
  T _handleResponse<T>(Response response) {
    // 这里可以根据你的API返回格式进行调整
    // 假设标准返回格式为: {code: int, message: string, data: T}
    try {
      if (response.statusCode == HttpStatus.ok) {
        // 如果期望的返回类型是 Response，则直接返回
        if (T == Response) {
          return response as T;
        }
        
        // 解析业务数据
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final int code = responseData['code'] ?? 0;
          final String message = responseData['message'] ?? '';
          
          // 根据业务码处理
          if (code == 200 || code == 0) {
            // 成功状态码，返回数据部分
            return responseData['data'] as T;
          } else {
            // 业务错误
            throw NetworkException.businessError(code, message);
          }
        } else {
          // 非标准格式，直接返回原始数据
          return responseData as T;
        }
      } else {
        throw NetworkException.httpError(response.statusCode ?? 0, response.statusMessage ?? '');
      }
    } catch (e) {
      if (e is NetworkException) {
        rethrow;
      }
      throw NetworkException.unknown('数据解析失败');
    }
  }

  /// 处理网络错误
  NetworkException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException.timeout('请求超时');
        
      case DioExceptionType.badResponse:
        final response = error.response;
        if (response != null) {
          if (response.statusCode == HttpStatus.unauthorized) {
            return NetworkException.tokenExpired('登录已过期，请重新登录');
          } else if (response.statusCode == HttpStatus.forbidden) {
            return NetworkException.forbidden('没有权限访问该资源');
          } else if (response.statusCode == HttpStatus.notFound) {
            return NetworkException.notFound('请求的资源不存在');
          } else if (response.statusCode == HttpStatus.internalServerError) {
            return NetworkException.serverError('服务器内部错误');
          } else {
            return NetworkException.httpError(response.statusCode ?? 0, response.statusMessage ?? '');
          }
        }
        return NetworkException.unknown('未知错误');
        
      case DioExceptionType.cancel:
        return NetworkException.cancel('请求被取消');
        
      case DioExceptionType.badCertificate:
        return NetworkException.badCertificate('证书错误');
        
      case DioExceptionType.connectionError:
        return NetworkException.networkError('连接错误');
        
      default:
        if (error.error is SocketException) {
          return NetworkException.networkError('网络连接错误');
        }
        return NetworkException.unknown(error.message ?? '未知错误');
    }
  }

  /// 获取 Dio 实例（用于特殊情况）
  Dio get dio => _dio;
  
  /// 获取当前配置
  NetworkConfig get config => _config;
}