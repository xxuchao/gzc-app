import 'package:flutter/material.dart';

class EvidencePage extends StatelessWidget {
  const EvidencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('证件信息'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 搜索功能
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('时间范围'),
                ElevatedButton(
                  onPressed: () {
                    // 完成操作
                  },
                  child: Text('完成'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 这里可以根据实际数据设置
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('证件名称/编号'),
                    subtitle: Text('2025-09-05 16:16:53\n手动录入'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // 处理点击事件
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}