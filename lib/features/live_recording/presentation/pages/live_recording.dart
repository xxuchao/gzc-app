import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';


class LiveRecording extends StatefulWidget {
  const LiveRecording({super.key});

  @override
  State<LiveRecording> createState() => _LiveRecordingState();
}

class _LiveRecordingState extends State<LiveRecording> {
  bool _isRecording = false;
  String _timeText = "00:00:00";

  // 模拟时间计时器
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    // _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        _timeText = _formatTime(_seconds);
      });
    });
  }

  String _formatTime(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).floor();
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _toggleRecording(bool isRecording) {
    setState(() {
      _isRecording = isRecording;
    });

    if (_isRecording) {
      _startTimer(); // 开始计时
    } else {
      _timer?.cancel(); // 停止计时
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('现场录音'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Spacing.pageHorizontal),
        child: Column(
          spacing: Spacing.cardPadding,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            const Text(
              '您的服务处',
            ),
            const Text(
              '福建省厦门市云尚公证处',
            ),
            // 麦克风图标
            const Icon(
              Icons.mic,
              size: 72,
              color: Colors.black,
            ),
            // 时间显示
            Text(
              _timeText,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            // 提示信息卡片
            CustomCard(
              color: Color(0xFFf3f5f7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '温馨提示',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '录音最多支持录10小时，请控制好您的时间，10小时后将自动结束录音。\n\n'
                    '录音过程中，请确保app在运行，否则可能导致录音失败。',
                    style: TextStyle(color: Colors.grey[700]),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const Spacer(),
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 录音按钮
                InkResponse(
                  onTap: (){
                    _toggleRecording(true);
                  },
                  radius: 40,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 2),
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // 停止按钮
                InkResponse(
                  onTap: (){
                    _toggleRecording(false);
                  },
                  radius: 40,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 2),
                      color: _isRecording ? Colors.white : Colors.white,
                    ),
                    child: const Icon(
                      Icons.square,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}