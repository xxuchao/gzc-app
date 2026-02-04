// 电话拨号
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';

class PhoneDialing extends StatefulWidget {
  const PhoneDialing({super.key});

  @override
  State<PhoneDialing> createState() => _PhoneDialingState();
}

class _PhoneDialingState extends State<PhoneDialing> {
  // 主叫号码列表
  List<CallerNumber> _callerNumbers = [
    CallerNumber(number: "18966666666", isMain: true),
    CallerNumber(number: "18966666666", isMain: false),
    CallerNumber(number: "18966666666", isMain: false),
  ];

  // 被叫号码列表
  List<CalleeNumber> _calleeNumbers = [
    CalleeNumber(number: "18966666666", time: "2025-09-05 17:02:47"),
    CalleeNumber(number: "18966666666", time: "2025-09-05 17:02:47"),
    CalleeNumber(number: "18966666666", time: "2025-09-05 17:02:47"),
  ];

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
                children: [
                  // 主叫号码卡片
                  _buildCallerNumbersCard(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 被叫号码卡片
                  _buildCalleeNumbersCard(),
                  
                  SizedBox(height: Spacing.cardGap),
                  
                  // 注意提示
                  _buildNotice(),
                ],
              ),
            ),
          ),
          
          // 底部拨号按钮
          _buildDialButton(),
        ],
      ),
    );
  }

  // 主叫号码卡片
  Widget _buildCallerNumbersCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(title: "主叫号码"),
          
          SizedBox(height: Spacing.lg),
          
          // 主叫号码列表
          ...List.generate(_callerNumbers.length, (index) {
            return _buildCallerNumberRow(index);
          }),
          
          // 添加按钮
          Center(
            child: IconButton(
              onPressed: _addCallerNumber,
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

  // 构建主叫号码行
  Widget _buildCallerNumberRow(int index) {
    final caller = _callerNumbers[index];
    return Container(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: Row(
        children: [
          // 号码
          Expanded(
            child: Text(
              caller.number,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // 主叫标识
          if (caller.isMain)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.sm,
                vertical: Spacing.xs,
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
              ),
              child: const Text(
                "当前主叫",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          
          // 切换主叫按钮
          if (!caller.isMain) ...[
            SizedBox(width: Spacing.sm),
            GestureDetector(
              onTap: () => _switchMainCaller(index),
              child: Text(
                "切换主叫",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
          
          SizedBox(width: Spacing.sm),
          
          // 删除按钮
          GestureDetector(
            onTap: () => _removeCallerNumber(index),
            child: Text(
              "删除",
              style: TextStyle(
                color: tagDangerColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 被叫号码卡片
  Widget _buildCalleeNumbersCard() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTile(title: "被叫号码"),
          
          SizedBox(height: Spacing.lg),
          
          // 被叫号码列表
          ...List.generate(_calleeNumbers.length, (index) {
            return _buildCalleeNumberRow(index);
          }),
        ],
      ),
    );
  }

  // 构建被叫号码行
  Widget _buildCalleeNumberRow(int index) {
    final callee = _calleeNumbers[index];
    return Container(
      margin: EdgeInsets.only(bottom: Spacing.md),
      padding: EdgeInsets.symmetric(vertical: Spacing.sm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 号码
          Text(
            callee.number,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          // 时间
          Text(
            callee.time,
            style: TextStyle(
              fontSize: 12,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // 注意提示
  Widget _buildNotice() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "注：被叫号码为接号拨出的号码记录",
        style: TextStyle(
          fontSize: 12,
          color: tagDangerColor,
        ),
      ),
    );
  }

  // 底部拨号按钮
  Widget _buildDialButton() {
    return Container(
      padding: EdgeInsets.all(Spacing.pageHorizontal),
      child: Column(
        children: [
          // 拨号按钮
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: tagDangerColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: _startDialing,
              icon: const Icon(
                Icons.dialpad,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          
          // 底部安全区域
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  // 添加主叫号码
  void _addCallerNumber() {
    setState(() {
      _callerNumbers.add(CallerNumber(number: "18966666666", isMain: false));
    });
  }

  // 删除主叫号码
  void _removeCallerNumber(int index) {
    if (_callerNumbers.length > 1) {
      setState(() {
        // 如果删除的是主叫，需要设置新的主叫
        if (_callerNumbers[index].isMain && _callerNumbers.length > 1) {
          int newMainIndex = index == 0 ? 1 : 0;
          _callerNumbers[newMainIndex].isMain = true;
        }
        _callerNumbers.removeAt(index);
      });
    }
  }

  // 切换主叫
  void _switchMainCaller(int index) {
    setState(() {
      // 取消当前主叫
      for (var caller in _callerNumbers) {
        caller.isMain = false;
      }
      // 设置新主叫
      _callerNumbers[index].isMain = true;
    });
  }

  // 开始拨号
  void _startDialing() {
    _showDialPad();
  }

  // 显示拨号键盘
  void _showDialPad() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const DialPadBottomSheet();
      },
    );
  }
}

// 主叫号码数据类
class CallerNumber {
  String number;
  bool isMain;

  CallerNumber({
    required this.number,
    required this.isMain,
  });
}

// 被叫号码数据类
class CalleeNumber {
  String number;
  String time;

  CalleeNumber({
    required this.number,
    required this.time,
  });
}

// 拨号键盘底部抽屉组件
class DialPadBottomSheet extends StatefulWidget {
  const DialPadBottomSheet({super.key});

  @override
  State<DialPadBottomSheet> createState() => _DialPadBottomSheetState();
}

class _DialPadBottomSheetState extends State<DialPadBottomSheet> {
  String _phoneNumber = "15259227256";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.radiusLg),
          topRight: Radius.circular(Spacing.radiusLg),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Spacing.xl),
          child: Column(
            children: [
              // 顶部区域
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 电话号码显示
                  Expanded(
                    child: Text(
                      _phoneNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ),
                  
                  // 删除按钮
                  GestureDetector(
                    onTap: _deleteLastDigit,
                    child: Container(
                      padding: EdgeInsets.all(Spacing.xs),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: Spacing.xxxl),
              
              // 数字键盘
              Expanded(
                child: _buildNumberPad(),
              ),
              
              SizedBox(height: Spacing.xl),
              
              // 底部操作区
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  // 构建数字键盘
  Widget _buildNumberPad() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 第一行: 1 2 3
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton("1"),
            _buildNumberButton("2"),
            _buildNumberButton("3"),
          ],
        ),
        
        // 第二行: 4 5 6
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton("4"),
            _buildNumberButton("5"),
            _buildNumberButton("6"),
          ],
        ),
        
        // 第三行: 7 8 9
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton("7"),
            _buildNumberButton("8"),
            _buildNumberButton("9"),
          ],
        ),
        
        // 第四行: * 0 #
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton("*"),
            _buildNumberButton("0"),
            _buildNumberButton("#"),
          ],
        ),
      ],
    );
  }

  // 构建数字按钮
  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberPressed(number),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  // 构建底部操作区
  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 粘贴号码
        GestureDetector(
          onTap: _pasteNumber,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "粘贴",
                style: TextStyle(
                  fontSize: 14,
                  color: tagDangerColor,
                ),
              ),
              Text(
                "号码",
                style: TextStyle(
                  fontSize: 14,
                  color: tagDangerColor,
                ),
              ),
            ],
          ),
        ),
        
        // 拨号按钮
        GestureDetector(
          onTap: _makeCall,
          child: Container(
            width: 140,
            height: 50,
            decoration: BoxDecoration(
              color: tagDangerColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Center(
              child: Icon(
                Icons.phone,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        
        // 更多选项 (九宫格图标)
        GestureDetector(
          onTap: _showMoreOptions,
          child: Container(
            width: 30,
            height: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(),
                    SizedBox(width: 3),
                    _buildDot(),
                    SizedBox(width: 3),
                    _buildDot(),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(),
                    SizedBox(width: 3),
                    _buildDot(),
                    SizedBox(width: 3),
                    _buildDot(),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(),
                    SizedBox(width: 3),
                    _buildDot(),
                    SizedBox(width: 3),
                    _buildDot(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 构建小圆点
  Widget _buildDot() {
    return Container(
      width: 3,
      height: 3,
      decoration: const BoxDecoration(
        color: textColor,
        shape: BoxShape.circle,
      ),
    );
  }

  // 数字按键处理
  void _onNumberPressed(String number) {
    setState(() {
      if (_phoneNumber.length < 15) { // 限制号码长度
        _phoneNumber += number;
      }
    });
  }

  // 删除最后一位数字
  void _deleteLastDigit() {
    setState(() {
      if (_phoneNumber.isNotEmpty) {
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      }
    });
  }

  // 粘贴号码
  void _pasteNumber() {
    // 这里可以实现从剪贴板粘贴号码的功能
    print("粘贴号码");
  }

  // 拨打电话
  void _makeCall() {
    Navigator.of(context).pop();
    // 这里可以实现实际的拨号功能
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("开始通话"),
          content: Text("正在拨打 $_phoneNumber"),
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

  // 显示更多选项
  void _showMoreOptions() {
    print("显示更多选项");
  }
}