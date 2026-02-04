// 屏幕录制
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_box.dart';
import 'package:gzc_app/core/widgets/operate_button.dart';

class ScreenRecording extends StatefulWidget {
  const ScreenRecording({super.key});

  @override
  State<ScreenRecording> createState() => _ScreenRecordingState();
}

class _ScreenRecordingState extends State<ScreenRecording> {
  bool microphone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("屏幕录制")),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(Spacing.pageHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("开始录制"),
                  Text("点击开始录制后，系统将自动对手机屏幕所显示的内容进行录制，记录手机上的所有操作。为保障证据效力，取证时会自动断开无线网络，请注意开启移动网络。"),
                  SizedBox(height: Spacing.cardGap,),
                  Text("查看手机网络状态"),
                  Text("请您自行前往手机“设置”中查看手机网络状态，请使用移动数据网络，切勿连接WIFI或者代理。"),
                ],
              ),
            ),
            BottomBox(
              child: Row(
                spacing: Spacing.md,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Switch(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                          value: microphone,
                          onChanged: (bool value) {
                            setState(() {
                              microphone = value;
                            });
                          },
                          // activeColor: Colors.green,
                        ),
                        SizedBox(width: Spacing.smx),
                        Text("麦克风声音"),
                      ],
                    ),
                  ),
                  Expanded(flex: 1, child: OperateButton("开始录制", () {})),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
