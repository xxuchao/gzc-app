import 'package:flutter/material.dart';
import 'package:gzc_app/core/utils/app_message.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:toastification/toastification.dart';

/// AppMessage 使用示例
class AppMessageExample extends StatefulWidget {
  const AppMessageExample({super.key});

  @override
  State<AppMessageExample> createState() => _AppMessageExampleState();
}

class _AppMessageExampleState extends State<AppMessageExample> {
  int _clickCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppMessage 示例'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              AppMessage.dismissAll();
            },
            tooltip: '关闭所有提示',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Spacing.pageHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '点击次数: $_clickCount',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: Spacing.lg),
            
            // 测试单一提示（会替换之前的）
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _clickCount++;
                });
                AppMessage.info('这是第 $_clickCount 次点击');
              },
              child: const Text('连续点击测试（只显示最新的）'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 不同类型的提示
            ElevatedButton(
              onPressed: () {
                AppMessage.success('操作成功！');
              },
              child: const Text('成功提示'),
            ),
            
            SizedBox(height: Spacing.md),
            
            ElevatedButton(
              onPressed: () {
                AppMessage.error('操作失败！', description: '请检查网络连接后重试');
              },
              child: const Text('错误提示'),
            ),
            
            SizedBox(height: Spacing.md),
            
            ElevatedButton(
              onPressed: () {
                AppMessage.warning('警告信息', description: '这是一个警告提示');
              },
              child: const Text('警告提示'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 多个提示（不会替换之前的）
            ElevatedButton(
              onPressed: () {
                AppMessage.showMultiple(
                  title: '多个提示 ${DateTime.now().millisecondsSinceEpoch % 1000}',
                  type: ToastificationType.info,
                );
              },
              child: const Text('多个提示测试（不会替换）'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 底部提示
            ElevatedButton(
              onPressed: () {
                AppMessage.info(
                  '底部提示信息',
                  position: AppMessagePosition.bottom,
                );
              },
              child: const Text('底部提示'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 加载提示
            ElevatedButton(
              onPressed: () {
                final loadingToast = AppMessage.loading('正在加载...');
                
                // 3秒后自动关闭加载提示
                Future.delayed(const Duration(seconds: 3), () {
                  if (loadingToast != null) {
                    AppMessage.dismissAll();
                    AppMessage.success('加载完成！');
                  }
                });
              },
              child: const Text('加载提示（3秒后自动关闭）'),
            ),
            
            SizedBox(height: Spacing.lg),
            
            // 快捷方法示例
            const Text(
              '快捷方法示例：',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            
            SizedBox(height: Spacing.md),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      AppMessage.copySuccess();
                    },
                    child: const Text('复制成功'),
                  ),
                ),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      AppMessage.networkError();
                    },
                    child: const Text('网络错误'),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: Spacing.md),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      AppMessage.operationSuccess();
                    },
                    child: const Text('操作成功'),
                  ),
                ),
                SizedBox(width: Spacing.sm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      AppMessage.operationFailed();
                    },
                    child: const Text('操作失败'),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: Spacing.lg),
            
            // 关闭所有提示
            ElevatedButton(
              onPressed: () {
                AppMessage.dismissAll();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('关闭所有提示'),
            ),
          ],
        ),
      ),
    );
  }
}