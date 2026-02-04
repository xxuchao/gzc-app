
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/models/webview_args.dart';
import 'package:gzc_app/core/router/app_router.dart';
import 'package:gzc_app/core/theme/colors.dart' show actionColor, surfaceColor;
import 'package:gzc_app/core/theme/spacing.dart';
// import 'package:gzc_app/features/webview/webview.utils.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class ProtocolWebViewPage extends StatefulWidget {
//   final String title;
//   final String url;

//   const ProtocolWebViewPage({
//     super.key,
//     required this.title,
//     required this.url,
//   });

//   @override
//   State<ProtocolWebViewPage> createState() => _ProtocolWebViewPageState();
// }

// class _ProtocolWebViewPageState extends State<ProtocolWebViewPage> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }

class ProtocolAgreement extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String userAgreementUrl;
  final String privacyPolicyUrl;

  const ProtocolAgreement({
    super.key,
    required this.value,
    required this.onChanged,
    required this.userAgreementUrl,
    required this.privacyPolicyUrl,
  });

  // void _openWebView(BuildContext context, {required String title, required String url}) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) => ProtocolWebViewPage(title: title, url: url),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall!.copyWith(color: surfaceColor); //const TextStyle(color: surfaceColor, fontSize: 12, height: 1.3);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: Spacing.iconSm,
          height: Spacing.iconSm,
          child: Theme(
            data: ThemeData(unselectedWidgetColor: surfaceColor),
            child: Transform.scale(
              scale: 0.85,
              child: Checkbox(
                value: value,
                onChanged: (v) => onChanged(v ?? false),
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return actionColor;
                  }
                  return Colors.transparent;
                }),
                checkColor: surfaceColor,
                activeColor: surfaceColor,
                side: BorderSide(color: surfaceColor, width: 2.0)
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.sm),
        Flexible(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: textStyle, // 确保 textStyle 是定义好的
              children: [
                TextSpan(
                  text: '同意',
                  recognizer: TapGestureRecognizer()..onTap = () => onChanged(!value),
                ),
                TextSpan(
                  text: '《用户协议》',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => AppRouter.pushNamed(AppRoutes.webview, arguments: WebViewArgs(title: "用户协议", url: userAgreementUrl)), // openWebView(context, title: '用户协议', url: userAgreementUrl),
                ),
                TextSpan(
                  text: '《隐私政策》',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => AppRouter.pushNamed(AppRoutes.webview, arguments: WebViewArgs(title: "隐私政策", url: privacyPolicyUrl)),
                ),
                TextSpan(
                  text: '、并使用本机号码登录',
                  recognizer: TapGestureRecognizer()..onTap = () => onChanged(!value),
                ),
              ],
            ),
          ),
        )
        // Flexible(
        //   child: Wrap(
        //     alignment: WrapAlignment.center,
        //     crossAxisAlignment: WrapCrossAlignment.center,
        //     children: [
        //       InkWell(
        //         onTap: () => onChanged(!value),
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(vertical: Spacing.sm),
        //           child: Text('同意', style: textStyle),
        //         ),
        //       ),
        //       InkWell(
        //         onTap: () => _openWebView(
        //           context,
        //           title: '用户协议',
        //           url: userAgreementUrl,
        //         ),
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(vertical: Spacing.xs),
        //           child: Text('《用户协议》', style: textStyle),
        //         ),
        //       ),
        //       InkWell(
        //         onTap: () => _openWebView(
        //           context,
        //           title: '隐私政策',
        //           url: privacyPolicyUrl,
        //         ),
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(vertical: Spacing.sm),
        //           child: Text('《隐私政策》', style: textStyle),
        //         ),
        //       ),
        //       InkWell(
        //         onTap: () => onChanged(!value),
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(vertical: Spacing.sm),
        //           child: Text('、并使用本机号码登录', style: textStyle),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
