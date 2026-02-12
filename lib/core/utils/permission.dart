import 'package:permission_handler/permission_handler.dart';

/// 请求相机和存储权限
/// [requestStorage] 是否同时请求存储权限（用于保存照片/视频）
/// 返回值: true 表示所有所需权限均已授予，false 表示至少有一个权限被拒绝或永久拒绝
Future<bool> requestCameraPermission({bool requestStorage = false}) async {
  List<Permission> permissionsToRequest = [Permission.camera];

  // 如果需要存储权限，则添加进去
  if (requestStorage) {
    // Android 10 (Q) 及以上推荐使用作用域存储，可能不需要此权限
    // Android 9 (P) 及以下或需要写入公共目录时可能需要
    permissionsToRequest.add(Permission.storage);
  }

  // 添加录制音频权限（如果需要录像）
  permissionsToRequest.add(Permission.microphone);

  Map<Permission, PermissionStatus> statuses = await permissionsToRequest.request();

  // 检查是否有任何权限被拒绝或永久拒绝
  bool allGranted = true;
  for (var status in statuses.values) {
    if (status != PermissionStatus.granted) {
      allGranted = false;
      break;
    }
  }

  return allGranted;
}