import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            // FlutterLogo(),
            // FlutterLogo(),
            // FlutterLogo(),
            _RotatedColorfulBox(size: 100),
            // _RotatedColorfulBox(size: 100),
          ],
        ),
      ),
    );
  }
}

class _RotatedColorfulBox extends StatefulWidget {
  const _RotatedColorfulBox({Key? key, this.size, this.origion})
      : super(key: key);

  final double? size;
  final Offset? origion;

  @override
  _RotatedColorfulBoxState createState() => _RotatedColorfulBoxState();
}

class _RotatedColorfulBoxState extends State<_RotatedColorfulBox>
    with SingleTickerProviderStateMixin {
  final duration = const Duration(seconds: 3);
  late final AnimationController _controller;
  late final Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: duration, vsync: this)
      // 添加数值变化监听器
      ..addListener(() => setState(() {}))
      // 添加状态变化监听器
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          _controller.forward(from: 0);
        }
      });
    // 角度从 0 到 360 度，对应的弧度是 0 到 2π
    _angleAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_controller);
    // 要启动一下
    _controller.forward();
  }

  @override
  void dispose() {
    // 不要忘了要 dispose 掉 AnimationController
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      // 指定选择的角度（以弧度为单位），设定为正数表示顺时针旋转，反之逆时针
      // 圆的一周弧度数为：2πr/r = 2π，也就是 360° = 2π，即 1 度 = π/180 弧度
      // 因此角度转弧度公式为：角度值 * π/180
      // 实际项目中，可以写一个 extension 方便将角度转换为弧度，比如：45.rad
      angle: _angleAnimation.value,
      origin: widget.origion!,
      child: _ColorfulBox(size: widget.size!),
    );
  }
}

class _ColorfulBox extends StatelessWidget {
  const _ColorfulBox({Key? key, this.size = 100.0})
      : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.amber, Colors.pink]),
      ),
    );
  }
}
