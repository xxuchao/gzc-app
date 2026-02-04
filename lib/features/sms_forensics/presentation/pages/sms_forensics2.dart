// 短信取证 - 第二步
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';

class SmsForensics2 extends StatefulWidget {
  const SmsForensics2({super.key});

  @override
  State<SmsForensics2> createState() => _SmsForensics2State();
}

class _SmsForensics2State extends State<SmsForensics2> {
  // 接收对象列表
  List<RecipientData> _recipients = [
    RecipientData(),
    RecipientData(),
  ];

  // 选中的证据包
  String? _selectedEvidencePackage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短信存证'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Spacing.pageHorizontal),
              child: Column(
                children: [
                  // 接收对象卡片
                  _buildRecipientsCard(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 证据包选择卡片
                  _buildEvidencePackageCard(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 费用计算卡片
                  _buildCostCalculationCard(),
                ],
              ),
            ),
          ),
          
          // 底部操作按钮
          BottomOperate(
            rate: 2,
            btns: [
              OperateButtonData(
                "确定", 
                () {
                  print("确定操作");
                  // 这里可以添加提交逻辑
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 接收对象卡片
  Widget _buildRecipientsCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTile(
            title: "接收对象",
            sub: Text(
              "(限5人)",
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
              ),
            ),
          ),
          
          SizedBox(height: Spacing.lg),
          
          // 接收人列表
          ...List.generate(_recipients.length, (index) {
            return _buildRecipientRow(index);
          }),
          
          // 添加按钮
          if (_recipients.length < 5)
            Center(
              child: IconButton(
                onPressed: _addRecipient,
                icon: Container(
                  padding: EdgeInsets.all(Spacing.xs),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: secondaryTextColor,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 构建接收人行
  Widget _buildRecipientRow(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: Row(
        children: [
          // 姓名输入框
          Expanded(
            child: TextFormField(
              controller: _recipients[index].nameController,
              decoration: InputDecoration(
                hintText: "接收人姓名",
                hintStyle: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.md,
                ),
              ),
            ),
          ),
          
          SizedBox(width: Spacing.sm),
          
          // 手机号输入框
          Expanded(
            child: TextFormField(
              controller: _recipients[index].phoneController,
              decoration: InputDecoration(
                hintText: "接收人手机号",
                hintStyle: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.md,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          
          SizedBox(width: Spacing.sm),
          
          // 删除按钮
          if (_recipients.length > 1)
            GestureDetector(
              onTap: () => _removeRecipient(index),
              child: Text(
                "删除",
                style: TextStyle(
                  color: tagDangerColor,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 证据包选择卡片
  Widget _buildEvidencePackageCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(title: "证据包选择"),
          
          SizedBox(height: Spacing.lg),
          
          // 下拉选择框
          DropdownButtonFormField<String>(
            value: _selectedEvidencePackage,
            decoration: InputDecoration(
              hintText: "XXXXXXXXX证据包",
              hintStyle: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.md,
              ),
            ),
            items: [
              "证据包A",
              "证据包B", 
              "证据包C",
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedEvidencePackage = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  // 费用计算卡片
  Widget _buildCostCalculationCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleTile(title: "费用计算"),
              GestureDetector(
                onTap: () {
                  // 显示费用说明
                  _showCostExplanation();
                },
                child: Text(
                  "费用说明>>",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: Spacing.lg),
          
          // 费用计算公式
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
                height: 1.5,
              ),
              children: [
                const TextSpan(text: "短信费用 = 短信单价 * 短信条数 * 人数\n"),
                TextSpan(
                  text: "3",
                  style: TextStyle(color: tagDangerColor, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: "存证币/条/人*"),
                TextSpan(
                  text: "2",
                  style: TextStyle(color: tagDangerColor, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: "条*"),
                TextSpan(
                  text: "2",
                  style: TextStyle(color: tagDangerColor, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: "人 = "),
                TextSpan(
                  text: "12",
                  style: TextStyle(color: tagDangerColor, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: "存证币"),
              ],
            ),
          ),
          
          SizedBox(height: Spacing.md),
          
          // 显示定位信息
          Text(
            "显示定位XXXXXXXXXXXXXXXXXXXXXXX",
            style: TextStyle(
              color: primaryColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // 添加接收人
  void _addRecipient() {
    if (_recipients.length < 5) {
      setState(() {
        _recipients.add(RecipientData());
      });
    }
  }

  // 删除接收人
  void _removeRecipient(int index) {
    if (_recipients.length > 1) {
      setState(() {
        _recipients[index].dispose();
        _recipients.removeAt(index);
      });
    }
  }

  // 显示费用说明
  void _showCostExplanation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("费用说明"),
          content: const Text(
            "短信存证费用计算规则：\n\n"
            "• 短信单价：3存证币/条/人\n"
            "• 费用 = 单价 × 短信条数 × 接收人数\n"
            "• 最低收费：1存证币\n"
            "• 定位服务：免费提供",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("确定"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    for (var recipient in _recipients) {
      recipient.dispose();
    }
    super.dispose();
  }
}

// 接收人数据类
class RecipientData {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
  }
}