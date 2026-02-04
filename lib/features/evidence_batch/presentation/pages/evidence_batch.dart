import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';

class EvidenceBatchPage extends StatefulWidget {
  const EvidenceBatchPage({super.key});

  @override
  State<EvidenceBatchPage> createState() => _EvidenceBatchPageState();
}

class _EvidenceBatchPageState extends State<EvidenceBatchPage> {
  // 证据列表
  final List<EvidenceItem> _evidenceList = [
    EvidenceItem(
      id: "1",
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 手机拍照",
      time: "2025-09-05 16:16:53",
      isSelected: true, // 第一个默认选中
    ),
    EvidenceItem(
      id: "2",
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 手机录像",
      time: "2025-09-05 16:16:53",
      isSelected: false,
    ),
    EvidenceItem(
      id: "3",
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 现场录音",
      time: "2025-09-05 16:16:53",
      isSelected: false,
    ),
    EvidenceItem(
      id: "4",
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 电话录音",
      time: "2025-09-05 16:16:53",
      isSelected: false,
    ),
    EvidenceItem(
      id: "5",
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 屏幕录制",
      time: "2025-09-05 16:16:53",
      isSelected: false,
    ),
    EvidenceItem(
      id: "6",
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 网页取证",
      time: "2025-09-05 16:16:53",
      isSelected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('批量删除'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(Spacing.pageHorizontal),
                itemCount: _evidenceList.length,
                itemBuilder: (context, index) {
                  return _buildEvidenceItem(_evidenceList[index], index);
                },
              ),
            ),
            
            // 底部删除按钮
            _buildBottomDeleteButton(),
          ],
        ),
      ),
    );
  }

  // 构建证据项
  Widget _buildEvidenceItem(EvidenceItem item, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 取证时间和选择框
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "取证时间：${item.time}",
              style: TextStyle(
                fontSize: 12,
                color: secondaryTextColor,
              ),
            ),
            // 选择框
            Checkbox(
              value: item.isSelected,
              onChanged: (bool? value) {
                setState(() {
                  _evidenceList[index].isSelected = value ?? false;
                });
              },
              activeColor: primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
        
        SizedBox(height: Spacing.sm),
        
        // 证据内容卡片
        CustomCard(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              // 状态标签
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "网站",
                      style: TextStyle(
                        fontSize: 10,
                        color: tagDangerColor,
                      ),
                    ),
                    Text(
                      "点击查看",
                      style: TextStyle(
                        fontSize: 8,
                        color: tagDangerColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: Spacing.md),
              
              // 证据信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Spacing.xs),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: Spacing.lg),
      ],
    );
  }

  // 构建底部删除按钮
  Widget _buildBottomDeleteButton() {
    final selectedCount = _evidenceList.where((item) => item.isSelected).length;
    final hasSelected = selectedCount > 0;
    
    return Container(
      padding: EdgeInsets.all(Spacing.pageHorizontal),
      child: Column(
        children: [
          // 选择提示
          if (hasSelected)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: Spacing.sm),
              child: Text(
                "已选择 $selectedCount 个证据",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ),
          
          // 删除按钮
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: hasSelected ? _showDeleteConfirmDialog : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: hasSelected ? tagDangerColor : Colors.grey[300],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                ),
                elevation: 0,
              ),
              child: Text(
                "删除",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: hasSelected ? Colors.white : Colors.grey[500],
                ),
              ),
            ),
          ),
          
          // 底部安全区域
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog() {
    final selectedCount = _evidenceList.where((item) => item.isSelected).length;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("确认删除"),
          content: Text("确定要删除选中的 $selectedCount 个证据吗？删除后无法恢复。"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("取消"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteSelectedEvidence();
              },
              child: Text(
                "删除",
                style: TextStyle(color: tagDangerColor),
              ),
            ),
          ],
        );
      },
    );
  }

  // 删除选中的证据
  void _deleteSelectedEvidence() {
    setState(() {
      _evidenceList.removeWhere((item) => item.isSelected);
    });
    
    // 显示删除成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("删除成功"),
        duration: Duration(seconds: 2),
      ),
    );
    
    // 如果没有证据了，返回上一页
    if (_evidenceList.isEmpty) {
      Navigator.of(context).pop();
    }
  }
}

// 证据项数据类
class EvidenceItem {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  bool isSelected;

  EvidenceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isSelected = false,
  });
}