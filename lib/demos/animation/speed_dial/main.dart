import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 一个简单的可展开的浮动按钮菜单效果
///
/// 更详细的控制请参考这个插件：https://pub.dev/packages/flutter_speed_dial
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
  // 展开后的按钮图片
  final List<IconData> _icons = const [Icons.sms, Icons.mail, Icons.phone];
  final duration = const Duration(milliseconds: 350);
  var _direction = Axis.vertical;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      // 动画显示的持续时长
      duration: duration,
    );
  }

  @override
  void dispose() {
    // 别忘了要 dispose
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _makeWidgets() {
    return List.generate(_icons.length, (index) {
      Widget child = Container(
        width: 56.0,
        height: 70.0,
        alignment: FractionalOffset.center,
        child: FadeTransition(
          opacity: _controller,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              // 观察 Interval 区间上限是由 index 决定的，index 从顶部到底部依次变大
              // 所以越往顶部区间越大，越往底部区间就越小
              // 区间大意味着变化慢；区间小意味着变化快
              // 当正向运动时，底部图标显示的比顶部图标显示的要快，这样效果会比较酷
              // 当反向运动时，由于顶部最先触发到区间，所以顶部会先收缩，底部最后收缩
              // 但最终都会缩小到 0，只是底部收缩的更快
              curve: Interval(
                0.0,
                1.0 - index / _icons.length,
                curve: Curves.easeOut,
              ),
            ),
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Theme.of(context).cardColor,
              mini: true,
              child: Icon(
                _icons[index],
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {},
            ),
          ),
        ),
      );
      return child;
    }).toList()
      // 往列表中添加一个右下角的触发按钮
      ..add(
        FloatingActionButton(
          heroTag: null,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                // 绕着 Z轴 旋转，正向是顺时针，负向是逆时针
                // 圆的一周弧度数为：2πr/r = 2π，也就是 360° = 2π，
                // 即 1° = π/180（弧度）
                // 此处定义的是从 0 转到 135 度（需转换为弧度）
                transform: Matrix4.rotationZ(
                  _controller.value * (135 / 180) * math.pi,
                ),
                // FractionalOffset 和 Alignment 的区别是：
                // FractionalOffset 以父级的左上角为原点；Align 以父级的中心为原点
                alignment: FractionalOffset.center,
                child: const Icon(Icons.add),
              );
            },
          ),
          onPressed: () {
            if (_controller.isDismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            setState(() {
              _direction = _direction == Axis.horizontal
                  ? Axis.vertical
                  : Axis.horizontal;
            });
          },
          child: const Text('切换显示方向'),
        ),
      ),
      // 常见的浮动按钮一般只设置一个 FloatingActionButton，但不要思维定势了，
      // 实际上可以是任意的 Widget，此处将多个 Widget 放入 Column 中
      floatingActionButton: _direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: _makeWidgets(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: _makeWidgets(),
            ),
    );
  }
}
