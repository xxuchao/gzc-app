// 短信取证
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/functional_dialog.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';
import 'package:gzc_app/features/sms_forensics/presentation/pages/sms_forensics2.dart';

class SmsForensics extends StatefulWidget {
  const SmsForensics({super.key});

  @override
  State<SmsForensics> createState() => _SmsForensicsState();
}

class _SmsForensicsState extends State<SmsForensics> {
  // 表单控制器
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // 当前选中的短信模板类型
  String _selectedTemplate = "会议通知";

  @override
  void initState() {
    super.initState();
    // 初始化表单数据
    _senderController.text = "张三先生";
    _receiverController.text = "李四先生";
    _subjectController.text = "公司第21次股东会";
    _dateController.text = "2019年3月1日";
    _phoneController.text = "李四先生13912345678";
    
    // 延迟到下一帧后弹窗
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showFunctionalDialog(context: context, showCloseButton: false, title: Text("短信取证须知"), content: Text("根据情况书写须知"), primaryAction: DialogAction(
        text: "确定",
        onPressed: () => Navigator.of(context).pop(),
      ));
    });
  }

  @override
  void dispose() {
    _senderController.dispose();
    _receiverController.dispose();
    _subjectController.dispose();
    _dateController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短信存证'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Spacing.pageHorizontal),
              child: Column(
                children: [
                  // 短信模板卡片
                  _buildSmsTemplateCard(),
                  
                  // 完善短信信息卡片
                  _buildSmsFormCard(),
                ],
              ),
            ),
          ),
          
          // 底部操作按钮
          BottomOperate(
            rate: 2,
            btns: [
              OperateButtonData(
                "下一步", 
                () {
                  // 跳转到第二个界面
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SmsForensics2(),
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

  // 短信模板卡片
  Widget _buildSmsTemplateCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TitleTile(title: "短信模板"),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.sm,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: tagDangerColor,
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: GestureDetector(
                  onTap: _showTemplateSelector,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedTemplate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: Spacing.xs),
                      const Icon(
                        Icons.remove_circle,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: Spacing.md),
          
          // 短信内容
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: textColor,
                  fontSize: 14,
                  height: 1.5,
                ),
                children: _buildTemplateTextSpans(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 完善短信信息表单卡片
  Widget _buildSmsFormCard() {
    return CustomCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(title: "完善短信"),
          
          SizedBox(height: Spacing.lg),
          
          // 表单字段
          _buildFormField("", _senderController, "张三先生"),
          _buildFormField("", _receiverController, "李四先生"),
          _buildFormField("", _subjectController, "公司第21次股东会"),
          _buildFormField("", _dateController, "2019年3月1日"),
          _buildFormField("", _phoneController, "李四先生13912345678", isLast: true),
        ],
      ),
    );
  }

  // 构建表单字段
  Widget _buildFormField(
    String label, 
    TextEditingController controller, 
    String placeholder, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
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
        if (!isLast) SizedBox(height: Spacing.md),
      ],
    );
  }

  // 显示模板选择器底部抽屉
  void _showTemplateSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Spacing.radiusLg),
              topRight: Radius.circular(Spacing.radiusLg),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 模板选项
                _buildTemplateOption("会议通知"),
                _buildTemplateOption("答复通知"),
                _buildTemplateOption("本方履行通知"),
                
                // 分隔线
                Container(
                  height: 8,
                  color: backgroundColor,
                ),
                
                // 取消按钮
                _buildCancelButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  // 构建模板选项
  Widget _buildTemplateOption(String templateName) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTemplate = templateName;
        });
        Navigator.pop(context);
        _updateTemplateContent(templateName);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: Spacing.lg,
          horizontal: Spacing.pageHorizontal,
        ),
        child: Center(
          child: Text(
            templateName,
            style: const TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  // 构建取消按钮
  Widget _buildCancelButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: Spacing.lg,
          horizontal: Spacing.pageHorizontal,
        ),
        child: const Center(
          child: Text(
            "取消",
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  // 根据选择的模板更新内容
  void _updateTemplateContent(String templateName) {
    switch (templateName) {
      case "会议通知":
        _senderController.text = "张三先生";
        _receiverController.text = "李四先生";
        _subjectController.text = "公司第21次股东会";
        _dateController.text = "2019年3月1日";
        _phoneController.text = "李四先生13912345678";
        break;
      case "答复通知":
        _senderController.text = "王五先生";
        _receiverController.text = "赵六先生";
        _subjectController.text = "合同答复事宜";
        _dateController.text = "2019年3月5日";
        _phoneController.text = "赵六先生13987654321";
        break;
      case "本方履行通知":
        _senderController.text = "公司法务部";
        _receiverController.text = "合作方";
        _subjectController.text = "合同履行通知";
        _dateController.text = "2019年3月10日";
        _phoneController.text = "法务部18812345678";
        break;
    }
  }

  // 构建带样式的文本片段
  List<TextSpan> _buildTemplateTextSpans() {
    switch (_selectedTemplate) {
      case "会议通知":
        return [
          const TextSpan(text: "张三先生"),
          const TextSpan(
            text: '"云上存"',
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "移动存证平台受"),
          const TextSpan(
            text: "李四先生",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "委托，向您发送短信通知如下："),
          const TextSpan(
            text: "公司第21次股东会",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "将于"),
          const TextSpan(
            text: "2019年3月1日",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "在四川省成都市公司成都办事处召开，请您准时参加，具体事宜请联系"),
          const TextSpan(
            text: "李四先生13912345678",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "(请勿回复本平台号码)"),
        ];
      case "答复通知":
        return [
          const TextSpan(text: "王五先生"),
          const TextSpan(
            text: '"云上存"',
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "移动存证平台受"),
          const TextSpan(
            text: "赵六先生",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "委托，向您发送短信通知如下：关于"),
          const TextSpan(
            text: "合同答复事宜",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "需要您在"),
          const TextSpan(
            text: "2019年3月5日",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "前给予回复，具体事宜请联系"),
          const TextSpan(
            text: "赵六先生13987654321",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "(请勿回复本平台号码)"),
        ];
      case "本方履行通知":
        return [
          const TextSpan(text: "公司法务部"),
          const TextSpan(
            text: '"云上存"',
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "移动存证平台受"),
          const TextSpan(
            text: "合作方",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "委托，向您发送短信通知如下："),
          const TextSpan(
            text: "合同履行通知",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "将于"),
          const TextSpan(
            text: "2019年3月10日",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "正式生效，具体事宜请联系"),
          const TextSpan(
            text: "法务部18812345678",
            style: TextStyle(color: primaryColor),
          ),
          const TextSpan(text: "(请勿回复本平台号码)"),
        ];
      default:
        return [const TextSpan(text: "")];
    }
  }
}