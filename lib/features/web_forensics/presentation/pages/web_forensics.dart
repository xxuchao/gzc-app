import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';

class WebForensics extends StatefulWidget {
  const WebForensics({super.key});

  @override
  State<WebForensics> createState() => _WebForensicsState();
}

class _WebForensicsState extends State<WebForensics> {
  final List<String> _urls = []; // 存储用户输入的 URL
  final TextEditingController _controller = TextEditingController();

  void _addUrl() {
    setState(() {
      _urls.add("123123123");
    });
  }

  void _removeUrl(int index) {
    setState(() {
      _urls.removeAt(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('网页取证')),
      body: Column(
        children: [
          // 温馨提示卡片
          CustomCard(
            margin: EdgeInsets.only(
              top: Spacing.pageTop,
              bottom: Spacing.cardGap,
              left: Spacing.pageHorizontal,
              right: Spacing.pageHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleTile(title: "温馨提示"),
                const SizedBox(height: 8),
                const Text(
                  '在证据网址栏输入完整的待取证网址(URL)，点击“开始截取网页”，系统自动抓取网页截图证据;系统抓取成功后，证据状态变为“待保存”状态，如满足取证要求，点击“存证”。\n\n'
                  '未存证，不收取费用，免费保存15天。\n'
                  '每个证据网址（网页）存证收取 1 个存证币。',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // 截取网页区域
          Expanded(
            child: CustomCard(
              margin: EdgeInsets.only(
                bottom: Spacing.cardGap,
                left: Spacing.pageHorizontal,
                right: Spacing.pageHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleTile(title: "截取网页"),

                  // URL 输入框列表
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true, // 不撑满整个屏幕
                      itemCount: _urls.length, // 最后一个是“+”按钮
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: '请输入您要取证的网址(URL)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                  keyboardType: TextInputType.url,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.qr_code_scanner, size: 18),
                                onPressed: () {
                                  // 扫码功能占位
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('扫码功能暂未实现')),
                                  );
                                },
                                splashRadius: 20,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                onPressed: () => _removeUrl(index),
                                splashRadius: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // 添加按钮
                  Center(
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.add, size: 24),
                      onPressed: _addUrl,
                      splashRadius: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomOperate(
            rate: 2,
            btns: [
              OperateButtonData("开始截取网页", () => {print("申请添加人")}),
            ],
          ),
        ],
      ),
    );
  }
}
