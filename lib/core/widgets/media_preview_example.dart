import 'package:flutter/material.dart';
import 'package:gzc_app/core/widgets/media_preview.dart';
import 'package:gzc_app/core/theme/spacing.dart';

/// 媒体预览组件使用示例
class MediaPreviewExample extends StatelessWidget {
  const MediaPreviewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('媒体预览示例'),
      ),
      body: Padding(
        padding: EdgeInsets.all(Spacing.pageHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 单张图片预览
            ElevatedButton(
              onPressed: () => _showSingleImage(context),
              child: const Text('预览单张图片'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 多张图片预览
            ElevatedButton(
              onPressed: () => _showMultipleImages(context),
              child: const Text('预览多张图片'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 混合媒体预览
            ElevatedButton(
              onPressed: () => _showMixedMedia(context),
              child: const Text('预览混合媒体'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 视频预览（预留）
            ElevatedButton(
              onPressed: () => _showVideo(context),
              child: const Text('预览视频（预留）'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 文档预览（预留）
            ElevatedButton(
              onPressed: () => _showDocument(context),
              child: const Text('预览文档（预留）'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 批量图片预览
            ElevatedButton(
              onPressed: () => _showBatchImages(context),
              child: const Text('批量图片预览'),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示单张图片
  void _showSingleImage(BuildContext context) {
    final mediaItem = MediaPreviewUtils.createImageFromUrl(
      'https://picsum.photos/800/600?random=1',
      title: '示例图片',
      description: '这是一张示例图片',
    );
    
    MediaPreviewUtils.showSingleMedia(context, mediaItem);
  }

  /// 显示多张图片
  void _showMultipleImages(BuildContext context) {
    final imageUrls = [
      'https://picsum.photos/800/600?random=1',
      'https://picsum.photos/800/600?random=2',
      'https://picsum.photos/800/600?random=3',
      'https://picsum.photos/800/600?random=4',
      'https://picsum.photos/800/600?random=5',
    ];
    
    final titles = [
      '美丽的风景 1',
      '美丽的风景 2', 
      '美丽的风景 3',
      '美丽的风景 4',
      '美丽的风景 5',
    ];
    
    final descriptions = [
      '第一张示例图片，展示美丽的自然风光',
      '第二张示例图片，色彩丰富',
      '第三张示例图片，构图优美',
      '第四张示例图片，光影效果佳',
      '第五张示例图片，意境深远',
    ];
    
    // 使用便捷的图片画廊方法
    MediaPreviewUtils.showImageGallery(
      context,
      imageUrls,
      titles: titles,
      descriptions: descriptions,
      initialIndex: 1, // 从第二张开始
    );
  }

  /// 显示混合媒体
  void _showMixedMedia(BuildContext context) {
    final mediaItems = [
      MediaPreviewUtils.createImageFromUrl(
        'https://picsum.photos/800/600?random=4',
        title: '图片',
        description: '一张图片',
      ),
      MediaPreviewUtils.createVideoFromUrl(
        'https://example.com/video.mp4',
        title: '视频',
        description: '一个视频文件',
      ),
      MediaPreviewUtils.createDocumentFromUrl(
        'https://example.com/document.pdf',
        title: '文档',
        description: '一个PDF文档',
      ),
    ];
    
    MediaPreviewUtils.showMultipleMedia(context, mediaItems);
  }

  /// 显示视频
  void _showVideo(BuildContext context) {
    final mediaItem = MediaPreviewUtils.createVideoFromUrl(
      'https://example.com/video.mp4',
      title: '示例视频',
      description: '这是一个示例视频',
    );
    
    MediaPreviewUtils.showSingleMedia(context, mediaItem);
  }

  /// 显示文档
  void _showDocument(BuildContext context) {
    final mediaItem = MediaPreviewUtils.createDocumentFromUrl(
      'https://example.com/document.pdf',
      title: '示例文档',
      description: '这是一个示例PDF文档',
    );
    
    MediaPreviewUtils.showSingleMedia(context, mediaItem);
  }

  /// 批量图片预览示例
  void _showBatchImages(BuildContext context) {
    final imageUrls = List.generate(10, (index) => 
      'https://picsum.photos/800/600?random=${index + 10}');
    
    final mediaItems = MediaPreviewUtils.createImagesFromUrls(
      imageUrls,
      titles: List.generate(10, (index) => '批量图片 ${index + 1}'),
      descriptions: List.generate(10, (index) => '这是第 ${index + 1} 张批量创建的图片'),
    );
    
    MediaPreviewUtils.showMultipleMedia(
      context, 
      mediaItems,
      initialIndex: 2, // 从第3张开始
    );
  }
}