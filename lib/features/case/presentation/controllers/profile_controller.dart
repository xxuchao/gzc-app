import 'package:get/get.dart';
import '../../../../core/network/net_client.dart';

class ProfileController extends GetxController {
  // 网络请求工具
  final NetClient _dioClient = Get.find<NetClient>();
  
  // 状态管理
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final userProfile = {}.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
  
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // 模拟网络请求延迟
      await Future.delayed(const Duration(seconds: 1));
      
      // 假设这是从API获取的数据
      final profileData = {
        'id': '1',
        'name': '张三',
        'email': 'zhangsan@example.com',
        'phone': '13800138000',
        'avatar': 'https://via.placeholder.com/100',
        'department': '技术部',
        'position': '高级工程师',
      };
      
      userProfile.assignAll(profileData);
    } catch (e) {
      errorMessage.value = '获取个人信息失败: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> updateProfile(Map<String, dynamic> updateData) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // 模拟网络请求延迟
      await Future.delayed(const Duration(seconds: 1));
      
      // 更新本地数据
      userProfile.assignAll(Map.from(userProfile) 
        ..addAll(updateData));
      
      errorMessage.value = '更新成功';
    } catch (e) {
      errorMessage.value = '更新个人信息失败: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
