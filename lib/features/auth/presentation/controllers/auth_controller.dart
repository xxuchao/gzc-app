import 'package:get/get.dart';
import '../../../../core/network/net_client.dart';

class AuthController extends GetxController {
  // 状态管理
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isLoggedIn = false.obs;
  final userInfo = {}.obs;
  
  // 网络请求工具
  final NetClient _dioClient = Get.find<NetClient>();
  
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
  
  // 检查登录状态
  void checkLoginStatus() {
    // 这里可以从本地存储检查登录状态
    // 例如：isLoggedIn.value = await GetStorage().read('isLoggedIn') ?? false;
    isLoggedIn.value = false;
  }
  
  // 登录
  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // 模拟网络请求延迟
      await Future.delayed(const Duration(seconds: 1));
      
      // 假设登录成功，返回用户信息
      if (username == 'admin' && password == 'password') {
        userInfo.value = {
          'id': '1',
          'name': '张三',
          'username': 'admin',
          'avatar': 'https://via.placeholder.com/100',
        };
        isLoggedIn.value = true;
        
        // 这里可以保存登录状态到本地存储
        // await GetStorage().write('isLoggedIn', true);
        // await GetStorage().write('userInfo', userInfo.value);
      } else {
        throw Exception('用户名或密码错误');
      }
    } catch (e) {
      errorMessage.value = '登录失败: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
  
  // 退出登录
  Future<void> logout() async {
    try {
      isLoading.value = true;
      
      // 模拟网络请求延迟
      await Future.delayed(const Duration(seconds: 1));
      
      // 清除用户信息和登录状态
      userInfo.value = {};
      isLoggedIn.value = false;
      
      // 这里可以清除本地存储的登录状态
      // await GetStorage().remove('isLoggedIn');
      // await GetStorage().remove('userInfo');
    } catch (e) {
      errorMessage.value = '退出登录失败: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
