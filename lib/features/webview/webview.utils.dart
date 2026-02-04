import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // 可选：加返回按钮（默认已有）
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

// void openWebView(BuildContext context, {required String title, required String url}) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (_) => WebViewPage(title: title, url: url),
//     ),
//   );
// }