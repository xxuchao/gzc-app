# 云尚公证处

## 项目介绍
这是一个基于Flutter的公证处APP，用于查询和提交公证服务。

## 项目信息
- 开始日期: 2025-11-26
- 开发者: XuCode
- 版本: 1.0.0
- 平台: Android, iOS
- 依赖:
  - Flutter 3.32.7
  - Dart 3.8.1
  - DevTools 2.45.1
  - Android SDK 36.0.0
  - Chrome 120.0.6099.224
  - Visual Studio 2019 16.11.49
  - Android Studio 2025.1.1
  - Java 21.0.8
  

## 环境配置
flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, 3.32.7, on Microsoft Windows [版本 10.0.19045.6456], locale zh-CN)
[√] Windows Version (10 专业版 64 位, 22H2, 2009)
[√] Android toolchain - develop for Android devices (Android SDK version 36.0.0)
[√] Chrome - develop for the web
[√] Visual Studio - develop Windows apps (Visual Studio 生成工具 2019 16.11.49)
[√] Android Studio (version 2025.1.1)
[√] Connected device (3 available)

java -version
java version "21.0.8" 2025-07-15 LTS
Java(TM) SE Runtime Environment (build 21.0.8+12-LTS-250)
Java HotSpot(TM) 64-Bit Server VM (build 21.0.8+12-LTS-250, mixed mode, sharing)

## 项目结构
gzc_app/                          # 项目根目录
├── android/                      # Android 原生代码
├── ios/                          # iOS 原生代码
├── lib/                          # Dart 核心代码（重点！）
│   ├── main.dart                 # 应用入口（最小化逻辑）
│   │
│   ├── core/                     # 核心通用模块（与业务无关）
│   │   ├── constants/            # 全局常量（colors, strings, routes 等）
│   │   ├── utils/                # 工具类（date, validators, extensions 等）
│   │   ├── network/              # 网络层（dio 配置、拦截器、API client）
│   │   ├── exceptions/           # 自定义异常
│   │   └── widgets/              # 通用 UI 组件（CustomButton, AppLoader 等）
│   │
│   ├── features/                 # 按功能模块划分（核心！）
│   │   └── auth/                 # 示例：登录/注册功能
│   │       ├── data/             # 数据层
│   │       │   ├── models/       # 数据模型（可含 fromJson/toJson）
│   │       │   ├── datasources/  # 数据源（remote/local）
│   │       │   └── repositories/ # Repository 实现
│   │       ├── domain/           # 领域层（纯 Dart，无 Flutter 依赖）
│   │       │   ├── entities/     # 业务实体（比 model 更抽象）
│   │       │   ├── repositories/ # Repository 抽象接口
│   │       │   └── usecases/     # 业务用例（如 LoginUseCase）
│   │       └── presentation/     # 表现层（UI + ViewModel/Controller）
│   │           ├── pages/        # 页面（LoginPage, RegisterPage）
│   │           ├── widgets/      # 页面内专属组件
│   │           └── bloc/         # 或 cubit / provider / controller
│   │
│   ├── injection.config.dart     # （可选）依赖注入配置（get_it + injectable）
│   └── injection.dart            # 依赖注入容器初始化
│
├── test/                         # 单元测试 & widget 测试
│   ├── core/
│   └── features/
│       └── auth/
│           ├── data/
│           ├── domain/
│           └── presentation/
├── integration_test/             # 集成测试
├── assets/                       # 静态资源
│   ├── images/
│   ├── fonts/
│   ├── l10n/                     # 本地化文件（arb）
│   └── json/                     # 本地 JSON 数据（mock 用）
├── pubspec.yaml                  # 依赖管理
├── analysis_options.yaml         # 代码规范（lints）
└── README.md