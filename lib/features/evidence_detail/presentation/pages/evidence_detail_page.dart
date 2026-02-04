import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';

class EvidenceDetailPage extends StatefulWidget {
  const EvidenceDetailPage({super.key});

  @override
  State<EvidenceDetailPage> createState() => _EvidenceDetailPageState();
}

class _EvidenceDetailPageState extends State<EvidenceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('证据详情'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal),
              child: Column(
                children: [
                  // 证据基本信息卡片
                  _buildEvidenceBasicInfo(),
                  
                  // 证据详细信息卡片
                  _buildEvidenceDetailInfo(),
                  
                  // 备注卡片
                  _buildNotesCard(),
                ],
              ),
            ),
          ),
          
          // 底部操作按钮
          BottomOperate(
            rate: 3,
            btns: [
              OperateButtonData(
                "删除",
                () {
                  print("删除证据");
                  _showDeleteConfirmDialog();
                },
                backgroundColor: Colors.white,
                textColor: secondaryTextColor,
                showBorder: true,
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              OperateButtonData(
                "存证",
                () {
                  print("存证");
                  _showSaveEvidenceDialog();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 构建证据基本信息
  Widget _buildEvidenceBasicInfo() {
    return CustomCard(
      margin: EdgeInsets.only(top: Spacing.cardGap, bottom: Spacing.cardGap),
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
                  "证据名称证据名称证据名称证据名称....",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Spacing.xs),
                Text(
                  "彭于晏 | 网页取证",
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建证据详细信息
  Widget _buildEvidenceDetailInfo() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(title: "证据信息"),
          
          SizedBox(height: Spacing.lg),
          
          // 信息列表
          _buildInfoRow("取证时间", "2025-06-03 18:30:54"),
          _buildInfoRow("取证时长", "00:00:07"),
          _buildInfoRow("证据大小", "62.55KB"),
          _buildInfoRow("取证网址", "https://www.baidu.com"),
          _buildInfoRow("取证账号", "彭于晏"),
          _buildInfoRow("存证公证处", "福建省厦门市云尚公证处", isLast: true),
        ],
      ),
    );
  }

  // 构建信息行
  Widget _buildInfoRow(String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
            ),
            SizedBox(width: Spacing.md),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ),
          ],
        ),
        if (!isLast) ...[
          SizedBox(height: Spacing.lg),
          Divider(
            color: Colors.grey[200],
            height: 1,
          ),
          SizedBox(height: Spacing.lg),
        ],
      ],
    );
  }

  // 构建备注卡片
  Widget _buildNotesCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleTile(title: "备注"),
              GestureDetector(
                onTap: _showEditNotesDialog,
                child: Text(
                  "添加/修改",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: Spacing.verticalGapMd),
          
          // 备注内容区域
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Text(
              "暂无备注信息",
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("确认删除"),
          content: const Text("确定要删除这个证据吗？删除后无法恢复。"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("取消"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 执行删除操作
                print("确认删除证据");
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

  // 显示存证对话框
  void _showSaveEvidenceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("存证确认"),
          content: const Text("确定要对这个证据进行存证吗？"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("取消"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 执行存证操作
                print("确认存证");
              },
              child: const Text("确定"),
            ),
          ],
        );
      },
    );
  }

  // 显示编辑备注对话框
  void _showEditNotesDialog() {
    final TextEditingController notesController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("编辑备注"),
          content: TextField(
            controller: notesController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: "请输入备注信息...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("取消"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 保存备注
                print("保存备注: ${notesController.text}");
              },
              child: const Text("保存"),
            ),
          ],
        );
      },
    );
  }
}