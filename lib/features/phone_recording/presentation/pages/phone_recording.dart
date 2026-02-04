// 电话录音
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';
import 'package:gzc_app/features/phone_recording/presentation/pages/phone_dialing.dart';

class PhoneRecordingPage extends StatefulWidget {
  const PhoneRecordingPage({super.key});

  @override
  State<PhoneRecordingPage> createState() => _PhoneRecordingPageState();
}

class _PhoneRecordingPageState extends State<PhoneRecordingPage> {
  // 保存证据选择
  String _selectedEvidenceType = "证据包";
  String? _selectedEvidencePackage;
  
  // 单个案件选择
  String _selectedSingleCaseType = "单个案件";
  String? _selectedSingleCase;
  
  // 取证流程选择
  String _selectedProcess = "取证流程一";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('电话录音'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 费用说明
                  _buildCostDescription(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 保存证据卡片
                  _buildEvidenceCard(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 案件信息卡片
                  _buildCaseInfoCard(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 取证流程选择
                  _buildProcessSelectionCard(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 账户余额
                  _buildAccountBalance(),
                ],
              ),
            ),
          ),
          
          // 底部操作按钮
          BottomOperate(
            rate: 2,
            btns: [
              OperateButtonData(
                "开始拨号", 
                () {
                  // 跳转到拨号界面
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PhoneDialing(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 费用说明
  Widget _buildCostDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "费用说明",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        SizedBox(height: Spacing.sm),
        Text(
          "每分钟收费10个币，不足1分钟按1分钟收费标准。",
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
        Text(
          "证据免费存放3年。",
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
        SizedBox(height: Spacing.sm),
        Text(
          "提示:收费以存证成功为准，存证不成功不会扣费。本处将为该证据保管3年",
          style: TextStyle(
            fontSize: 12,
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }

  // 保存证据卡片
  Widget _buildEvidenceCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TitleTile(title: "保存证据"),
              SizedBox(width: Spacing.md),
              Text(
                "如果需拨号码没有证据包选择",
                style: TextStyle(
                  color: tagDangerColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          
          SizedBox(height: Spacing.lg),
          
          // 第一行选择
          Row(
            children: [
              _buildRadioOption("证据包", _selectedEvidenceType, (value) {
                setState(() {
                  _selectedEvidenceType = value!;
                });
              }),
              SizedBox(width: Spacing.xl),
              _buildRadioOption("单个案件", _selectedEvidenceType, (value) {
                setState(() {
                  _selectedEvidenceType = value!;
                });
              }),
              SizedBox(width: Spacing.xl),
              _buildRadioOption("项目案件", _selectedEvidenceType, (value) {
                setState(() {
                  _selectedEvidenceType = value!;
                });
              }),
            ],
          ),
          
          SizedBox(height: Spacing.md),
          
          // 证据包下拉选择
          if (_selectedEvidenceType == "证据包")
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
          
          SizedBox(height: Spacing.lg),
          
          // 第二行选择
          Row(
            children: [
              _buildRadioOption("证据包", _selectedSingleCaseType, (value) {
                setState(() {
                  _selectedSingleCaseType = value!;
                });
              }),
              SizedBox(width: Spacing.xl),
              _buildRadioOption("单个案件", _selectedSingleCaseType, (value) {
                setState(() {
                  _selectedSingleCaseType = value!;
                });
              }),
              SizedBox(width: Spacing.xl),
              _buildRadioOption("项目案件", _selectedSingleCaseType, (value) {
                setState(() {
                  _selectedSingleCaseType = value!;
                });
              }),
            ],
          ),
          
          SizedBox(height: Spacing.md),
          
          // 单个案件下拉选择
          if (_selectedSingleCaseType == "单个案件")
            DropdownButtonFormField<String>(
              value: _selectedSingleCase,
              decoration: InputDecoration(
                hintText: "输入案件名称或案件编号等取证案件",
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
                "案件A",
                "案件B", 
                "案件C",
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSingleCase = newValue;
                });
              },
            ),
        ],
      ),
    );
  }

  // 案件信息卡片
  Widget _buildCaseInfoCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "案件编号：202509051702208850000001",
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryTextColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // 删除案件
                  print("删除案件");
                },
                child: Text(
                  "删了吧",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: Spacing.sm),
          
          Text(
            "案件名称案件名称案件名称案件名称",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          
          SizedBox(height: Spacing.xs),
          
          Text(
            "网购 | 网购",
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
            ),
          ),
          
          SizedBox(height: Spacing.xs),
          
          Text(
            "2025-09-05 16:16:53",
            style: TextStyle(
              fontSize: 12,
              color: secondaryTextColor,
            ),
          ),
          
          SizedBox(height: Spacing.sm),
          
          Text(
            "* 请选择目标取证流程，证据将转移到该流程下",
            style: TextStyle(
              fontSize: 12,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // 取证流程选择卡片
  Widget _buildProcessSelectionCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProcessOption(
            "取证流程一",
            "(网购取证 | 手机取证)",
            _selectedProcess == "取证流程一",
            () {
              setState(() {
                _selectedProcess = "取证流程一";
              });
            },
          ),
          
          SizedBox(height: Spacing.md),
          
          _buildProcessOption(
            "取证流程二",
            "(网购取证 | 手机取证)",
            _selectedProcess == "取证流程二",
            () {
              setState(() {
                _selectedProcess = "取证流程二";
              });
            },
          ),
          
          SizedBox(height: Spacing.md),
          
          _buildProcessOption(
            "取证流程三",
            "(网购取证 | 手机取证)",
            _selectedProcess == "取证流程三",
            () {
              setState(() {
                _selectedProcess = "取证流程三";
              });
            },
          ),
        ],
      ),
    );
  }

  // 账户余额
  Widget _buildAccountBalance() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
          children: [
            const TextSpan(text: "账户余额："),
            TextSpan(
              text: "3650",
              style: TextStyle(
                color: authButtonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: "存证币"),
          ],
        ),
      ),
    );
  }

  // 构建单选按钮选项
  Widget _buildRadioOption(String title, String groupValue, ValueChanged<String?> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: title,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: primaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // 构建取证流程选项
  Widget _buildProcessOption(String title, String subtitle, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: isSelected,
            onChanged: (value) => onTap(),
            activeColor: primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
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
    );
  }
}