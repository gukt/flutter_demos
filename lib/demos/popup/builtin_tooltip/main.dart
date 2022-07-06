import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Home())));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<TooltipState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                debugPrint('正在通过手动方式显示 tooltip');
                key.currentState?.ensureTooltipVisible();
              },
              // Tooltip 遵循规范：https://material.io/components/tooltips
              child: Tooltip(
                key: key,
                message:
                    '我是提示，长按时会出现，深灰色底，浅灰色的字,我可以是很长一段文字，我可以是很长一段文字，我可以是很长一段文字, 我的宽度最大是屏幕宽度',
                // message 和 richMessage 仅能提供一个
                richMessage: null,
                // 控制内边距，默认左右 16
                padding: null,
                // 控制外边距，默认 0
                margin: null,
                // 控制垂直方向偏移值
                verticalOffset: null,
                // 是否默认显示在 child 的下面，默认 true，false 时表示显示在上面
                preferBelow: false,
                // 是否 tooltip 不包含在 semantics tree 上
                excludeFromSemantics: null,
                // 控制外形和颜色
                decoration: null,
                textStyle: null,
                // 鼠标悬停（或长按）多长时间后才显示 tooltip
                waitDuration: const Duration(seconds: 5),
                // 鼠标一开（或松开长按）后多长时间 tooltip 消失
                showDuration: const Duration(seconds: 5),
                // 如果为 null，则使用 TooltipThemeData.triggerMode，如果 TooltipThemeData.triggerMode 也为 null，则默认为 longPress
                // 有三种模式: longPress, tap, manual:
                // longPress 是默认的；tap: 点击即弹出，无需长按。manual: 工具提示只能通过调用 ensureTooltipVisible 来显示。
                triggerMode: TooltipTriggerMode.manual,
                // 是否应该提供声音和/或触觉反馈。
                // 例如，在Android上，当反馈功能被启用时，轻按会产生点击声，长按会产生短暂的震动
                // 如果设置为 null，则默认 true
                enableFeedback: true,
                child: const Text('text'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
