import 'package:flutter/material.dart';
import 'dart:math' as math;

///
/// See also:
/// - [A Deep Dive Into Transform Widgets in Flutter](https://medium.com/flutter-community/a-deep-dive-into-transform-widgets-in-flutter-4dc32cd575a9)
/// - [Advanced Flutter: Matrix4 And Perspective Transformations](https://medium.com/flutter-community/advanced-flutter-matrix4-and-perspective-transformations-a79404a0d828)
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 设定 scale = 1 表示正常尺寸，不做缩放
            // 如果不设定 origin，则默认 origin 是 child 的中心点
            Transform.scale(scale: 1.0, child: const _ColorfulBox()),
            // 以中心点宽高各缩放一半
            Transform.scale(scale: 0.5, child: const _ColorfulBox()),
            // 以中心点放大 2 倍
            Transform.scale(scale: 2.0, child: const _ColorfulBox()),
            // orgin 设定的 offset 是相对于中心点来说的，由于盒子尺寸为 50，因此相对于中心点 Offset(25, 25) 设定的就是缩放原点是。
            // origin: 左上角
            Transform.scale(
                scale: 2.0,
                origin: const Offset(-25, -25),
                child: const _ColorfulBox()),
            // origin: 右上角
            Transform.scale(
                scale: 2.0,
                origin: const Offset(25, -25),
                child: const _ColorfulBox()),
            // origin：左下角
            Transform.scale(
                scale: 2.0,
                origin: const Offset(-25, 25),
                child: const _ColorfulBox()),
            // origin: 右下角
            Transform.scale(
                scale: 2.0,
                origin: const Offset(25, 25),
                child: const _ColorfulBox()),
            // 水平方向放大
            Transform.scale(scaleX: 2, child: const _ColorfulBox()),
            // 垂直方向放大
            Transform.scale(scaleY: 2, child: const _ColorfulBox()),
            // const _RotatedColorfulBox(size: 100),
            // // 盒子的大小是 100，默认旋转点为child 的中心点，这里设置相对于原始中心点偏移的位置为 50，50，也就是盒子的右下角
            // // 你可以在 MaterialApp 中通过设定 debugShowMaterialGrid = true 以显示一个 grid 背景，可以帮我们更容易查看实际效果，也可以通过 Widget Inspector 中打开显示 “Overlay Gidelines”
            // const _RotatedColorfulBox(size: 100, origin: Offset(50, 50)),
          ],
        ),
      ),
    );
  }
}

class _RotatedColorfulBox extends StatefulWidget {
  const _RotatedColorfulBox({
    Key? key,
    this.size = 100,
    this.origin = const Offset(0, 0),
  }) : super(key: key);

  final double size;
  final Offset? origin;

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
      origin: widget.origin,
      child: _ColorfulBox(size: widget.size),
    );
  }
}

class _ColorfulBox extends StatelessWidget {
  const _ColorfulBox({Key? key, this.size = 50.0}) : super(key: key);
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
