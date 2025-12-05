import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gzc_app/main_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    // 实例化或查找控制器，使用 Get.put() 确保控制器只创建一次
    final MainController controller = Get.put(MainController());
    return Scaffold(
      // 使用 Obx (Observable Builder) 来监听 controller.currentIndex 的变化
      // 当 currentIndex 改变时，body 会自动重建，显示新的页面
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          // 当前选中项
          currentIndex: controller.currentIndex.value,
          
          // 切换选中项时调用控制器的方法
          onTap: controller.changePage,

          type: BottomNavigationBarType.fixed,

          // 设置 BottomNavigationBarItem
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monochrome_photos),
              label: '证据',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dns),
              label: '案件',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.design_services),
              label: '申办',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}