import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool show = true;
  final GlobalKey _logoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  show = !show;
                });
              },
              child: const Text('切换显示/隐藏'),
            ),
            ElevatedButton(
              onPressed: () {
                final RenderBox renderBox =
                    _logoKey.currentContext!.findRenderObject() as RenderBox;
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(content: Text('Size: ${renderBox.size}')),
                  );
              },
              child: const Text('获取图标大小'),
            ),
            // Offstage 用来将 child 放置在 Widget 树中，但不绘制任何东西；不让 child 用于命中测试；也不占父组件中的任何空间。
            // Stage 下的 child 仍然是活跃的，他们可以收到焦点，并且可以有直接的键盘输入。
            // 动画将继续在后台子进程中运行。因此，不管动画最终是否可见，都会占用内存和 CPU
            // 如果确定不再显示了，最好是将 child 从树中彻底移除掉。
            // OffStage 可以用来测量组件大小，而不需要将其显示在屏幕上（因为该子节点仍然在树上）
            // 如果想隐藏 child 同时还要禁用 child 上的 Animation，可以使用 TickerMode 包裹 child（TickerMode 只在应用了 AnimationController 的 Widget 上才生效）
            Offstage(
              // 表示是否不在 Stage 上，true 表示因此，默认 true
              offstage: !show,
              child: FlutterLogo(key: _logoKey, size: 48),
            ),
          ],
        ),
      ),
    );
  }
}
