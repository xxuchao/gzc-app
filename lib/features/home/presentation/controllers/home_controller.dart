import 'package:get/get.dart';
import '../../../../core/network/net_client.dart';

class HomeController extends GetxController {
  // 状态管理
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final data = [].obs;
  
  // 网络请求工具
  final NetClient _dioClient = Get.find<NetClient>();
  
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
  
  Future<void> fetchData() async {
    try {
      isLoading(true);
      errorMessage('');
      
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 2));
      
      // 这里可以替换为实际的API调用
      // final response = await _dioClient.get('/home/data');
      // data(response.data);
      
      // 模拟数据
      data([
        {'title': '公证服务', 'description': '提供各类公证服务', 'icon': '📄'},
        {'title': '在线预约', 'description': '快速预约公证时间', 'icon': '📅'},
        {'title': '进度查询', 'description': '查询公证办理进度', 'icon': '🔍'},
        {'title': '法律资讯', 'description': '最新法律资讯更新', 'icon': '📚'},
      ]);
    } catch (e) {
      errorMessage('获取数据失败，请重试');
      print('Error fetching data: $e');
    } finally {
      isLoading(false);
    }
  }
  
  void refreshData() {
    fetchData();
  }
}
