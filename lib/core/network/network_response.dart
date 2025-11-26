/// 标准API响应数据结构
class NetworkResponse<T> {
  /// 业务状态码
  final int code;

  /// 响应消息
  final String message;

  /// 返回数据
  final T? data;

  /// 时间戳
  final DateTime? timestamp;

  NetworkResponse({
    required this.code,
    required this.message,
    this.data,
    this.timestamp,
  });

  /// 是否成功
  bool get isSuccess => code == 200 || code == 0;

  /// 从Map创建NetworkResponse实例
  factory NetworkResponse.fromJson(Map<String, dynamic> json) {
    return NetworkResponse<T>(
      code: json['code'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      data: json['data'] as T?,
      timestamp: json['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int)
          : null,
    );
  }

  /// 转换为Map
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'NetworkResponse{code: $code, message: $message, data: $data, timestamp: $timestamp}';
  }
}