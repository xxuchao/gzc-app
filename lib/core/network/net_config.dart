// 网络环境枚举
enum Env { dev, test, prod }

class HttpKeys {
  // 用于标记请求是否需要跳过 AuthInterceptor 的 Token 注入
  static const String skipAuthHeader = 'skip_auth_header';
}

// 网络配置类
class HttpConfig {
  // 当前环境设置
  static const Env currentEnv = Env.dev;

  // 根据环境获取 BaseUrl
  static String get baseUrl {
    switch (currentEnv) {
      case Env.dev:
        return "https://dev-api.example.com";
      case Env.test:
        return "https://test-api.example.com";
      case Env.prod:
        return "https://api.example.com";
    }
  }

  // 是否启用日志
  static bool get enableLog => currentEnv != Env.prod;

  // 超时时间 (毫秒)
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;
}