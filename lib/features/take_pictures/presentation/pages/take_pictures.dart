// 拍照取证
import 'package:flutter/material.dart';

class TakingPictures extends StatefulWidget {
  const TakingPictures({super.key});

  @override
  State<TakingPictures> createState() => _TakingPicturesState();
}

class _TakingPicturesState extends State<TakingPictures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机拍照'),
      ),
      body: Center(
        child: Text("开发中"),
      ),
    );
  }
}