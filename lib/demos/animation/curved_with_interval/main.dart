import 'package:flutter/material.dart';

/// 本实例演示使用 Interval 限定在指定的区间值内执行曲线
void main() {
  runApp(const MaterialApp(home: Home()));
}

// 因为要控制动画，所以我们创建一个 StatefulWidget
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _sizeAnimation;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // 动画执行时长，因为本例要观察应用 Interval() 后产生的效果，所以将时间设置长一点
      duration: const Duration(seconds: 10),
    );
    // 添加值变化监听，每次值变化时都调用 setState() 将当前帧设置为 dirty
    _controller.addListener(() => setState(() {}));
    _sizeAnimation = Tween(begin: 50.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        // 设定当 _controller 的值在 [0, 0.5] 这个范围内，才执行大小变化动画
        // 换句话说，本来在整个动画从 0 到 1 期间都执行大小变化，共计 10 秒内完成，
        // 现在被压缩到  5 秒（因为总时长设定的是 10 秒）内执行大小变化整个过程
        curve: const Interval(0.0, 0.5),
      ),
    );
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.amber,
    ).animate(CurvedAnimation(
      parent: _controller,
      // 设定当 _controller 的值在 [0.7, 1] 这个范围内，才执行颜色变化动画
      // 换句话说，本来在整个动画从 0 到 1 期间都执行颜色变化，共计 10 秒内完成，
      // 现在被压缩到 3 秒（因为总时长设定的是 10 秒）内执行颜色变化整个过程
      // 结合前面对 _sizeAnimation 设定的区间，你可以观察到：
      // 在 [0.5-0.7] 这个区间只有颜色变化，没有大小变化
      curve: const Interval(0.7, 1),
    ));
  }

  @override
  void dispose() {
    // 别忘了要 dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            // 显示 AnimationController 当前值，保留 3 位小数
            Text('Controller Value: ${_controller.value.toStringAsFixed((3))}'),
            Text('Size: ${_sizeAnimation.value.toStringAsFixed((3))}'),
            Text('Color: ${_colorAnimation.value}'),
            Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              color: _colorAnimation.value,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isDismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
