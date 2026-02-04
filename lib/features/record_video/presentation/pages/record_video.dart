// 录像取证
import 'package:flutter/material.dart';

class RecordVideo extends StatefulWidget {
  const RecordVideo({super.key});

  @override
  State<RecordVideo> createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机录像'),
      ),
      body: Center(
        child: Text("开发中"),
      ),
    );
  }
}