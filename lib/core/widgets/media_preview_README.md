# 媒体预览组件 (MediaPreview)

一个功能完整的媒体预览组件，支持图片、视频、文档的预览，并支持多媒体切换。

## 功能特性

- ✅ 图片预览（基础实现，支持缩放、加载状态、错误处理）
- 🚧 图片预览（photo_view 增强版，需要添加依赖）
- 🔄 视频预览（预留接口）
- 🔄 文档预览（预留接口）
- ✅ 多媒体左右切换
- ✅ 页面指示器
- ✅ 标题和描述显示
- ✅ 更多操作菜单（分享、下载、详细信息）
- ✅ 全屏预览（除AppBar外占据整个内容区域）

## 安装依赖

要使用完整的图片预览功能，需要在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  photo_view: ^0.15.0
```

然后取消 `media_preview.dart` 中相关代码的注释。

## 使用方法

### 1. 基本用法

```dart
import 'package:gzc_app/core/widgets/media_preview.dart';

// 创建媒体项
final mediaItem = MediaItem(
  url: 'https://example.com/image.jpg',
  type: MediaType.image,
  title: '图片标题',
  description: '图片描述',
);

// 显示单个媒体
MediaPreviewUtils.showSingleMedia(context, mediaItem);
```

### 2. 多媒体预览

```dart
final mediaItems = [
  MediaItem(
    url: 'https://example.com/image1.jpg',
    type: MediaType.image,
    title: '图片 1',
  ),
  MediaItem(
    url: 'https://example.com/video.mp4',
    type: MediaType.video,
    title: '视频 1',
  ),
  MediaItem(
    url: 'https://example.com/document.pdf',
    type: MediaType.document,
    title: '文档 1',
  ),
];

// 显示多个媒体，从第2个开始
MediaPreviewUtils.showMultipleMedia(
  context, 
  mediaItems,
  initialIndex: 1,
);
```

### 3. 使用工具方法快速创建

```dart
// 创建图片媒体项
final imageItem = MediaPreviewUtils.createImageFromUrl(
  'https://example.com/image.jpg',
  title: '图片标题',
  description: '图片描述',
);

// 创建视频媒体项
final videoItem = MediaPreviewUtils.createVideoFromUrl(
  'https://example.com/video.mp4',
  title: '视频标题',
);

// 创建文档媒体项
final documentItem = MediaPreviewUtils.createDocumentFromUrl(
  'https://example.com/document.pdf',
  title: '文档标题',
);
```

### 4. 自定义配置

```dart
MediaPreviewUtils.showMultipleMedia(
  context,
  mediaItems,
  initialIndex: 0,           // 初始显示的媒体索引
  showIndicator: true,       // 是否显示页面指示器
  showTitle: true,           // 是否显示标题
  backgroundColor: Colors.black, // 背景颜色
);
```

## 数据结构

### MediaItem

```dart
class MediaItem {
  final String url;          // 媒体URL
  final MediaType type;      // 媒体类型
  final String? title;       // 标题（可选）
  final String? description; // 描述（可选）
}
```

### MediaType

```dart
enum MediaType {
  image,    // 图片
  video,    // 视频
  document, // 文档
}
```

## 组件特性

### 图片预览
- 支持缩放（0.5x - 3.0x）
- 加载状态指示器
- 错误状态处理
- 网络图片加载

### 视频预览（预留）
- 播放控制
- 进度条
- 音量控制
- 全屏播放

### 文档预览（预留）
- PDF 预览
- 文档翻页
- 缩放功能
- 搜索功能

### 通用功能
- 左右滑动切换
- 页面指示器
- 标题和描述显示
- 更多操作菜单
- 全屏沉浸式体验

## 扩展开发

### 添加新的媒体类型

1. 在 `MediaType` 枚举中添加新类型
2. 在 `_buildMediaWidget` 方法中添加对应的构建逻辑
3. 实现对应的预览组件

### 自定义操作菜单

修改 `_showMoreOptions` 方法，添加自定义的操作选项。

### 自定义样式

通过构造函数参数自定义背景颜色、指示器样式等。

## 注意事项

1. 图片预览目前使用基础的 `InteractiveViewer`，要获得更好的体验请添加 `photo_view` 依赖
2. 视频和文档预览功能需要根据具体需求实现
3. 网络媒体加载需要处理网络权限和错误情况
4. 大文件预览需要考虑内存管理和性能优化

## 示例

查看 `media_preview_example.dart` 文件获取完整的使用示例。