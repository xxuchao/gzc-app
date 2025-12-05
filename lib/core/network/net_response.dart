// 网络请求响应类
class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
  });

  // 判断业务逻辑是否成功 (根据后端约定，例如 code == 200)
  bool get isSuccess => code == 200;

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponse(
      code: json['code'] as int? ?? -1,
      message: json['message'] as String? ?? '',
      data: (json['data'] != null && fromJsonT != null) ? fromJsonT(json['data']) : json['data'],
    );
  }
}