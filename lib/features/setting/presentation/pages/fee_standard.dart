import 'package:flutter/material.dart';

class FeeStandardPage extends StatelessWidget {
  FeeStandardPage({super.key});
  final List<Map<String, String>> feeStandards = [
    {
      "title": "现场录音",
      "description":
          "确认并保存证据成功后根据录音的时长计费\n每分钟收费10个币，不足1分钟按1分钟计算，证据免费保存3年。",
    },
    {
      "title": "手机录像",
      "description":
          "确认并保存证据成功后根据录像时长计费\n每分钟收费10个币，不足1分钟按1分钟计算，证据免费保存3年。",
    },
    {
      "title": "线上证据",
      "description":
          "确认并保存证据成功后根据截图张数计费\n计费标准为20币/张，证据免费保存3年。",
    },
    {
      "title": "电话录音",
      "description":
          "拨通被叫号码后开始计时：若被叫方接听，则按照接通通话的时长进行计费\n每分钟收费10个币，不足1分钟按1分钟计算，证据免费保存3年。",
    },
    {
      "title": "屏幕录制",
      "description":
          "确认并保存证据成功后根据录像的时长计费\n每分钟收费20个币，不足1分钟按1分钟计算，证据免费保存3年。",
    },
    {
      "title": "网页取证",
      "description":
          "确认并保存证据成功后根据截图张数计费\n计费标准为20币/张，证据免费保存3年。",
    },
    {
      "title": "证明服务",
      "description": "电子数据证据证明书\n目前免费申请出具。",
    },
    {
      "title": "公证服务",
      "description": "本处提供相关公证服务内容收取公证费。",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("收费标准"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: feeStandards.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.qr_code_2,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              title: Text(
                feeStandards[index]["title"]!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                feeStandards[index]["description"]!,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      ),
    );
  }
}