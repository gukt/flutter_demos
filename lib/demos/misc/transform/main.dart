import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          children: [
            Transform.rotate(
              // 这个参数是用来设定将 child 旋转的角度（以弧度为单位），
              // 正数表示顺时针旋转；负数表示逆时针方向旋转
              // 圆的一周弧度数为：2πr/r = 2π，也就是 360° = 2π，
              // 即 1 度对应的弧度为 π/180, 因此角度转弧度公式为：角度值 * π/180
              angle: 45 * math.pi / 180,
              child: const FlutterLogo(size: 50),
            ),
            Transform.scale(
              scale: 2,
              child: const FlutterLogo(size: 50),
            ),
            const CustomAnimatedRotatedBox(),
            const CustomAnimatedRotatedBox(origin: Offset(-25, -25)),
          ],
        ),
      ),
    );
  }
}

class CustomRotatedBox extends StatelessWidget {
  const CustomRotatedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        // 这个参数是用来设定将 child 旋转的角度（以弧度为单位），
        // 正数表示顺时针旋转；负数表示逆时针方向旋转
        // 圆的一周弧度数为：2πr/r = 2π，也就是 360° = 2π，
        // 即 1 度对应的弧度为 π/180, 因此角度转弧度公式为：角度值 * π/180
        angle: 45 * math.pi / 180,
        child: const FlutterLogo(size: 50));
  }
}

class CustomAnimatedRotatedBox extends StatefulWidget {
  const CustomAnimatedRotatedBox({
    Key? key,
    this.width = 50,
    this.height = 50,
    this.origin = const Offset(0, 0),
  }) : super(key: key);

  final double width;
  final double height;
  final Offset origin;

  @override
  _CustomAnimatedRotatedBoxState createState() =>
      _CustomAnimatedRotatedBoxState();
}

class _CustomAnimatedRotatedBoxState extends State<CustomAnimatedRotatedBox>
    with SingleTickerProviderStateMixin<CustomAnimatedRotatedBox> {
  late final AnimationController _controller;
  late final Animation<double> _radianAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.completed) {
          _controller.forward(from: 0);
        }
      });

    // 弧度动画
    _radianAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _radianAnimation.value,
      origin: widget.origin,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber, Colors.pink],
          ),
        ),
      ),
    );
  }
}
