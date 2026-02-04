// 电子合同
import 'package:flutter/material.dart';

class ElectronicContract extends StatefulWidget {
  const ElectronicContract({super.key});

  @override
  State<ElectronicContract> createState() => _ElectronicContractState();
}

class _ElectronicContractState extends State<ElectronicContract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电子合同"),
      ),
      body: Center(
        child: Text("暂无，看对接平台"),
      ),
    );
  }
}