// lib/core/http/dio_client.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'net_config.dart';
import 'net_exception.dart';
import 'net_response.dart';
import 'net_interceptor.dart';
import 'net_log_interceptor.dart';

class NetClient {
  // 1. 单例模式
  static final NetClient _instance = NetClient._internal();
  factory NetClient() => _instance;
  
  late final Dio _dio;

  NetClient._internal() {
    // 2. 初始化 Dio 配置
    BaseOptions options = BaseOptions(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: HttpConfig.connectTimeout),
      receiveTimeout: const Duration(milliseconds: HttpConfig.receiveTimeout),
      responseType: ResponseType.json,
    );
    
    _dio = Dio(options);

    // 3. 添加拦截器
    _addInterceptors();
  }

  void _addInterceptors() {
    // 1. 添加业务拦截器
    _dio.interceptors.add(AuthInterceptor());

    // 2. 添加日志拦截器
    if (HttpConfig.enableLog) {
      _dio.interceptors.add(CustomLogInterceptor.instance);
    }
  }

  // --- 核心请求方法 ---

  /// GET 请求
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    return _request<T>(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      fromJson: fromJson,
    );
  }

  /// POST 请求
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    return _request<T>(
      path,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      fromJson: fromJson,
    );
  }
  
  // PUT 和 DELETE 类似，此处省略，参照 POST 即可...

  // --- 统一请求实现 ---
  Future<ApiResponse<T>> _request<T>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
        cancelToken: cancelToken,
      );

      // 解析响应
      return ApiResponse.fromJson(response.data, fromJson);
    } catch (e) {
      throw NetException.create(e);
    }
  }

  // --- 5. 文件操作 (大文件) ---

  /// 下载文件
  /// [savePath] 本地保存路径
  /// [onReceiveProgress] 进度回调
  Future<void> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        deleteOnError: true, // 出错删除未完成文件
      );
    } catch (e) {
      throw NetException.create(e);
    }
  }

  /// 上传文件 (支持大文件流式上传)
  /// [filePath] 文件路径
  /// [onSendProgress] 上传进度
  Future<ApiResponse<T>> uploadFile<T>(
    String path,
    String filePath, {
    String fileKey = 'file', // 后端接收文件的字段名
    Map<String, dynamic>? otherData, // 其他参数
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        throw NetException("文件不存在", -4);
      }
      
      String fileName = filePath.split('/').last;

      // 使用 MultipartFile.fromFile 即使是几个G的视频也能处理
      // 因为它不会一次性把文件读入内存，而是流式读取
      FormData formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
        if (otherData != null) ...otherData,
      });

      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data", // 显式声明，虽然 Dio 会自动处理
          },
          // 增加超时时间，大文件上传需要更久
          sendTimeout: const Duration(minutes: 30), 
        ),
      );

      return ApiResponse.fromJson(response.data, fromJson);
    } catch (e) {
      throw NetException.create(e);
    }
  }
}