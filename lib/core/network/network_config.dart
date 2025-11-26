/// 网络配置类
class NetworkConfig {
  /// 基础URL
  final String baseUrl;

  /// API密钥
  final String? apiKey;

  /// 认证令牌
  final String? authToken;

  /// 是否启用日志
  final bool enableLog;

  /// 连接超时时间（毫秒）
  final int connectTimeout;

  /// 接收超时时间（毫秒）
  final int receiveTimeout;

  /// 发送超时时间（毫秒）
  final int sendTimeout;

  NetworkConfig({
    required this.baseUrl,
    this.apiKey,
    this.authToken,
    this.enableLog = true,
    this.connectTimeout = 10000,
    this.receiveTimeout = 10000,
    this.sendTimeout = 10000,
  });

  /// 开发环境配置
  factory NetworkConfig.dev() {
    return NetworkConfig(
      baseUrl: 'https://dev-api.gongzhengchu.com',
      enableLog: true,
    );
  }

  /// 测试环境配置
  factory NetworkConfig.test() {
    return NetworkConfig(
      baseUrl: 'https://test-api.gongzhengchu.com',
      enableLog: true,
    );
  }

  /// 生产环境配置
  factory NetworkConfig.prod() {
    return NetworkConfig(
      baseUrl: 'https://api.gongzhengchu.com',
      enableLog: false,
    );
  }
}