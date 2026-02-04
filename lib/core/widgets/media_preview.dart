import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:gzc_app/core/theme/spacing.dart';

/// 媒体类型枚举
enum MediaType {
  image,
  video,
  document,
}

/// 媒体项数据类
class MediaItem {
  final String url;
  final MediaType type;
  final String? title;
  final String? description;

  MediaItem({
    required this.url,
    required this.type,
    this.title,
    this.description,
  });
}

/// 媒体预览组件
class MediaPreview extends StatefulWidget {
  /// 媒体列表
  final List<MediaItem> mediaItems;
  
  /// 初始显示的媒体索引
  final int initialIndex;
  
  /// 是否显示指示器（多个媒体时）
  final bool showIndicator;
  
  /// 是否显示标题
  final bool showTitle;
  
  /// 背景颜色
  final Color? backgroundColor;

  const MediaPreview({
    super.key,
    required this.mediaItems,
    this.initialIndex = 0,
    this.showIndicator = true,
    this.showTitle = true,
    this.backgroundColor,
  });

  @override
  State<MediaPreview> createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: widget.showTitle && widget.mediaItems[_currentIndex].title != null
            ? Text(
                widget.mediaItems[_currentIndex].title!,
                style: const TextStyle(color: Colors.white),
              )
            : null,
        actions: [
          // 可以添加更多操作按钮，如分享、下载等
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: Stack(
        children: [
          // 主要内容区域
          _buildMainContent(),
          
          // 底部指示器和信息
          if (widget.showIndicator && widget.mediaItems.length > 1)
            _buildBottomInfo(),
        ],
      ),
    );
  }

  /// 构建主要内容区域
  Widget _buildMainContent() {
    // 如果只有一个媒体项，直接显示
    if (widget.mediaItems.length == 1) {
      return _buildMediaWidget(widget.mediaItems[0]);
    }

    // 检查是否全部都是图片
    final allImages = widget.mediaItems.every((item) => item.type == MediaType.image);
    
    if (allImages) {
      // 全部是图片时，使用 PhotoViewGallery
      return PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          final mediaItem = widget.mediaItems[index];
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(mediaItem.url),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3.0,
            heroAttributes: PhotoViewHeroAttributes(tag: mediaItem.url),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: Spacing.md),
                  Text(
                    '图片加载失败',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget.mediaItems.length,
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            value: event == null 
                ? null 
                : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
            color: Colors.white,
          ),
        ),
        backgroundDecoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.black,
        ),
        pageController: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      );
    } else {
      // 混合媒体类型时，使用 PageView
      return PageView.builder(
        controller: _pageController,
        itemCount: widget.mediaItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return _buildMediaWidget(widget.mediaItems[index]);
        },
      );
    }
  }

  /// 构建单个媒体组件
  Widget _buildMediaWidget(MediaItem mediaItem) {
    switch (mediaItem.type) {
      case MediaType.image:
        return _buildImagePreview(mediaItem);
      case MediaType.video:
        return _buildVideoPreview(mediaItem);
      case MediaType.document:
        return _buildDocumentPreview(mediaItem);
    }
  }

  /// 构建图片预览
  Widget _buildImagePreview(MediaItem mediaItem) {
    // 如果只有一张图片，使用 PhotoView
    if (widget.mediaItems.length == 1) {
      return PhotoView(
        imageProvider: NetworkImage(mediaItem.url),
        backgroundDecoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.black,
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3.0,
        initialScale: PhotoViewComputedScale.contained,
        heroAttributes: PhotoViewHeroAttributes(tag: mediaItem.url),
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            value: event == null 
                ? null 
                : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
            color: Colors.white,
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: Spacing.md),
              Text(
                '图片加载失败',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
    
    // 多张图片时，返回简单的图片组件，由 PhotoViewGallery 处理
    return Image.network(
      mediaItem.url,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
            color: Colors.white,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 48,
            ),
            SizedBox(height: Spacing.md),
            Text(
              '图片加载失败',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建视频预览（预留）
  Widget _buildVideoPreview(MediaItem mediaItem) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_circle_outline,
            color: Colors.white,
            size: 80,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            '视频预览功能',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            '即将上线',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          if (mediaItem.title != null) ...[
            SizedBox(height: Spacing.lg),
            Text(
              mediaItem.title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  /// 构建文档预览（预留）
  Widget _buildDocumentPreview(MediaItem mediaItem) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            color: Colors.white,
            size: 80,
          ),
          SizedBox(height: Spacing.lg),
          Text(
            '文档预览功能',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: Spacing.sm),
          Text(
            '即将上线',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          if (mediaItem.title != null) ...[
            SizedBox(height: Spacing.lg),
            Text(
              mediaItem.title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  /// 构建底部信息栏
  Widget _buildBottomInfo() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 页面指示器
              if (widget.mediaItems.length > 1) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.mediaItems.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == _currentIndex
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Spacing.sm),
              ],
              
              // 当前页面信息
              Text(
                '${_currentIndex + 1} / ${widget.mediaItems.length}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              
              // 描述信息
              if (widget.mediaItems[_currentIndex].description != null) ...[
                SizedBox(height: Spacing.sm),
                Text(
                  widget.mediaItems[_currentIndex].description!,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 显示更多选项
  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Spacing.radiusLg),
            topRight: Radius.circular(Spacing.radiusLg),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.share),
                title: Text('分享'),
                onTap: () {
                  Navigator.pop(context);
                  _shareMedia();
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text('下载'),
                onTap: () {
                  Navigator.pop(context);
                  _downloadMedia();
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('详细信息'),
                onTap: () {
                  Navigator.pop(context);
                  _showMediaInfo();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 分享媒体（预留）
  void _shareMedia() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('分享功能即将上线')),
    );
  }

  /// 下载媒体（预留）
  void _downloadMedia() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('下载功能即将上线')),
    );
  }

  /// 显示媒体信息（预留）
  void _showMediaInfo() {
    final currentMedia = widget.mediaItems[_currentIndex];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('媒体信息'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentMedia.title != null) ...[
              Text('标题: ${currentMedia.title}'),
              SizedBox(height: Spacing.sm),
            ],
            Text('类型: ${_getMediaTypeText(currentMedia.type)}'),
            SizedBox(height: Spacing.sm),
            Text('链接: ${currentMedia.url}'),
            if (currentMedia.description != null) ...[
              SizedBox(height: Spacing.sm),
              Text('描述: ${currentMedia.description}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 获取媒体类型文本
  String _getMediaTypeText(MediaType type) {
    switch (type) {
      case MediaType.image:
        return '图片';
      case MediaType.video:
        return '视频';
      case MediaType.document:
        return '文档';
    }
  }
}

/// 媒体预览工具类
class MediaPreviewUtils {
  /// 显示单个媒体预览
  static void showSingleMedia(
    BuildContext context,
    MediaItem mediaItem, {
    bool showTitle = true,
    Color? backgroundColor,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaPreview(
          mediaItems: [mediaItem],
          showTitle: showTitle,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  /// 显示多个媒体预览
  static void showMultipleMedia(
    BuildContext context,
    List<MediaItem> mediaItems, {
    int initialIndex = 0,
    bool showIndicator = true,
    bool showTitle = true,
    Color? backgroundColor,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaPreview(
          mediaItems: mediaItems,
          initialIndex: initialIndex,
          showIndicator: showIndicator,
          showTitle: showTitle,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  /// 显示图片画廊（专门用于多张图片预览）
  static void showImageGallery(
    BuildContext context,
    List<String> imageUrls, {
    int initialIndex = 0,
    List<String>? titles,
    List<String>? descriptions,
    bool showIndicator = true,
    bool showTitle = true,
    Color? backgroundColor,
  }) {
    final mediaItems = imageUrls.asMap().entries.map((entry) {
      final index = entry.key;
      final url = entry.value;
      return MediaItem(
        url: url,
        type: MediaType.image,
        title: titles != null && index < titles.length ? titles[index] : null,
        description: descriptions != null && index < descriptions.length ? descriptions[index] : null,
      );
    }).toList();

    showMultipleMedia(
      context,
      mediaItems,
      initialIndex: initialIndex,
      showIndicator: showIndicator,
      showTitle: showTitle,
      backgroundColor: backgroundColor,
    );
  }

  /// 从网络URL创建图片媒体项
  static MediaItem createImageFromUrl(
    String url, {
    String? title,
    String? description,
  }) {
    return MediaItem(
      url: url,
      type: MediaType.image,
      title: title,
      description: description,
    );
  }

  /// 从网络URL创建视频媒体项
  static MediaItem createVideoFromUrl(
    String url, {
    String? title,
    String? description,
  }) {
    return MediaItem(
      url: url,
      type: MediaType.video,
      title: title,
      description: description,
    );
  }

  /// 从网络URL创建文档媒体项
  static MediaItem createDocumentFromUrl(
    String url, {
    String? title,
    String? description,
  }) {
    return MediaItem(
      url: url,
      type: MediaType.document,
      title: title,
      description: description,
    );
  }

  /// 批量创建图片媒体项
  static List<MediaItem> createImagesFromUrls(
    List<String> urls, {
    List<String>? titles,
    List<String>? descriptions,
  }) {
    return urls.asMap().entries.map((entry) {
      final index = entry.key;
      final url = entry.value;
      return MediaItem(
        url: url,
        type: MediaType.image,
        title: titles != null && index < titles.length ? titles[index] : null,
        description: descriptions != null && index < descriptions.length ? descriptions[index] : null,
      );
    }).toList();
  }
}