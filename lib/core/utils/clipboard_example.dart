import 'package:flutter/material.dart';
import 'package:gzc_app/core/utils/clipboard_utils.dart';
import 'package:gzc_app/core/theme/spacing.dart';

/// 剪贴板工具使用示例
class ClipboardExample extends StatefulWidget {
  const ClipboardExample({super.key});

  @override
  State<ClipboardExample> createState() => _ClipboardExampleState();
}

class _ClipboardExampleState extends State<ClipboardExample> {
  String _clipboardContent = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('剪贴板工具示例'),
      ),
      body: Padding(
        padding: EdgeInsets.all(Spacing.pageHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 基本复制功能
            ElevatedButton(
              onPressed: () => _copySimpleText(),
              child: const Text('复制简单文本'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 复制长文本
            ElevatedButton(
              onPressed: () => _copyLongText(),
              child: const Text('复制长文本'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 复制多行文本
            ElevatedButton(
              onPressed: () => _copyMultilineText(),
              child: const Text('复制多行文本'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 复制键值对
            ElevatedButton(
              onPressed: () => _copyKeyValueData(),
              child: const Text('复制键值对数据'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 自定义提示消息
            ElevatedButton(
              onPressed: () => _copyWithCustomMessage(),
              child: const Text('复制并显示自定义消息'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 静默复制（不显示提示）
            ElevatedButton(
              onPressed: () => _copySilently(),
              child: const Text('静默复制（无提示）'),
            ),
            
            SizedBox(height: Spacing.lg),
            
            // 获取剪贴板内容
            ElevatedButton(
              onPressed: () => _getClipboardContent(),
              child: const Text('获取剪贴板内容'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 检查剪贴板是否有内容
            ElevatedButton(
              onPressed: () => _checkClipboardContent(),
              child: const Text('检查剪贴板是否有内容'),
            ),
            
            SizedBox(height: Spacing.md),
            
            // 清空剪贴板
            ElevatedButton(
              onPressed: () => _clearClipboard(),
              child: const Text('清空剪贴板'),
            ),
            
            SizedBox(height: Spacing.lg),
            
            // 显示剪贴板内容
            Container(
              padding: EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '剪贴板内容：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Spacing.sm),
                  Text(
                    _clipboardContent.isEmpty ? '(空)' : _clipboardContent,
                    style: TextStyle(
                      color: _clipboardContent.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 复制简单文本
  void _copySimpleText() {
    ClipboardUtils.copyText(
      '这是一段简单的文本',
      context: context,
    );
  }

  /// 复制长文本
  void _copyLongText() {
    const longText = '''
这是一段很长的文本内容，用来测试复制长文本的功能。
这段文本包含了多个句子，并且有一定的长度。
通过这个示例，我们可以验证复制功能是否能够正确处理较长的文本内容。
''';
    
    ClipboardUtils.copyText(
      longText.trim(),
      context: context,
      message: '长文本已复制',
    );
  }

  /// 复制多行文本
  void _copyMultilineText() {
    final lines = [
      '第一行文本',
      '第二行文本',
      '第三行文本',
      '第四行文本',
    ];
    
    ClipboardUtils.copyLines(
      lines,
      context: context,
    );
  }

  /// 复制键值对数据
  void _copyKeyValueData() {
    final data = {
      '姓名': '张三',
      '年龄': '25',
      '职业': '软件工程师',
      '城市': '北京',
      '邮箱': 'zhangsan@example.com',
    };
    
    ClipboardUtils.copyKeyValuePairs(
      data,
      context: context,
    );
  }

  /// 复制并显示自定义消息
  void _copyWithCustomMessage() {
    ClipboardUtils.copyWithCustomMessage(
      '自定义消息示例文本',
      context,
      successMessage: '🎉 复制成功！内容已保存到剪贴板',
      errorMessage: '❌ 复制失败，请重试',
      duration: const Duration(seconds: 3),
    );
  }

  /// 静默复制
  void _copySilently() {
    ClipboardUtils.copyText(
      '这是静默复制的文本',
      context: context,
      showMessage: false,
    );
    
    // 手动显示提示
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('静默复制完成（手动提示）'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  /// 获取剪贴板内容
  void _getClipboardContent() async {
    final content = await ClipboardUtils.getText();
    setState(() {
      _clipboardContent = content ?? '(无内容)';
    });
  }

  /// 检查剪贴板是否有内容
  void _checkClipboardContent() async {
    final hasContent = await ClipboardUtils.hasText();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(hasContent ? '剪贴板有内容' : '剪贴板为空'),
        backgroundColor: hasContent ? Colors.green : Colors.orange,
      ),
    );
  }

  /// 清空剪贴板
  void _clearClipboard() {
    ClipboardUtils.clear(context: context);
    setState(() {
      _clipboardContent = '';
    });
  }
}