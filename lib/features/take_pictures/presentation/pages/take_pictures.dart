// 拍照取证
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakingPictures extends StatefulWidget {
  const TakingPictures({super.key});

  @override
  State<TakingPictures> createState() => _TakingPicturesState();
}

class _TakingPicturesState extends State<TakingPictures> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // 1. 获取可用摄像头列表
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        // 如果没有找到摄像头，可以处理错误
        print("No cameras found on device!");
        if (mounted) {
          // 可以在这里设置一个错误状态并重建 UI // 检查是否仍挂载
          setState(() {
            // 例如，可以设置一个 _hasError 变量
          });
        }
        return;
      }

      // 2. 选择一个摄像头（这里选择第一个）
      final firstCamera = cameras.first;

      // 3. 创建控制器
      _controller = CameraController(
        firstCamera, // 现在传递 CameraDescription 对象
        ResolutionPreset.medium,
      );

      // 4. 初始化控制器
      _initializeControllerFuture = _controller!
          .initialize(); // 注意非空断言 !，因为刚创建了它

      // 5. 等待初始化完成
      await _initializeControllerFuture;

      // 6. 初始化完成后，如果 Widget 仍然挂载，则重建 UI
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error initializing camera: $e');
      // 可以在这里设置错误状态并重建 UI
      if (mounted) {
        // 例如，可以设置一个 _hasError 变量
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose(); // 使用安全调用 ?. 来释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 检查控制器是否已初始化
    if (_controller == null || !_controller!.value.isInitialized) {
      // 如果尚未初始化，显示加载指示器
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('相机加载中'),
            ],
          ),
        ),
      );
    }

    // 控制器已初始化，构建相机 UI
    return Scaffold(
      // 顶部操作栏
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.flash_on, color: Colors.white),
                onPressed: () {
                  // TODO: 实现闪光灯切换逻辑
                  print("Flash button pressed");
                },
              ),
              DropdownButton<String>(
                value: '4:3', // 示例值，实际应绑定状态变量
                items: [
                  DropdownMenuItem(child: Text('4:3'), value: '4:3'),
                  DropdownMenuItem(child: Text('16:9'), value: '16:9'),
                  // 添加更多比例选项...
                ],
                onChanged: (String? newValue) {
                  // TODO: 实现画面比例切换逻辑
                  if (newValue != null) {
                    print("Aspect ratio changed to: $newValue");
                  }
                },
                dropdownColor: Colors.grey[800],
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.flip_camera_ios, color: Colors.white),
                onPressed: () {
                  // TODO: 实现镜头反转逻辑
                  print("Flip camera button pressed");
                },
              ),
            ],
          ),
        ),
      ),
      // 中间预览区和左下角信息
      body: Stack(
        children: [
          CameraPreview(_controller!), // 使用非空断言，因为在此处已确认初始化
          // 左下角信息
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "定位位置", // TODO: 替换为实际位置
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    DateTime.now().toString(), // 系统时间
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // 底部操作栏
      bottomNavigationBar: Container(
        height: 100, // 设置固定高度
        color: Colors.black.withOpacity(0.5),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                // 返回按钮逻辑，例如 Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            // 拍照按钮 (圆形)
            GestureDetector(
              onTap: () async {
                if (_controller != null && _controller!.value.isInitialized) {
                  try {
                    await _initializeControllerFuture; // 等待初始化完成
                    final XFile photo = await _controller!.takePicture();
                    print('Picture saved to ${photo.path}');
                    // TODO: 处理拍摄的照片，例如显示预览或保存
                  } catch (e) {
                    print('Error taking picture: $e');
                    // TODO: 处理拍照错误
                  }
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.0),
                  color: Colors.transparent, // 透明填充，形成圆环效果
                ),
              ),
            ),
            // 已拍摄照片预览区域 (示例)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300], // 占位符颜色
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.image, color: Colors.grey[600]), // 占位符图标
            ),
          ],
        ),
      ),
    );
  }
}
