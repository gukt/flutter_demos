import 'package:flutter/material.dart';

/// Transform.scale 演示
///
/// Transform 小部件在绘制之前“变换”（即改变形状、大小、位置和方向）它的 child。
/// 这意味着： 变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以我们能看到变化之后相互部分遮盖（可通过 Widget Inspector 中打开显示 “Overlay Gidelines” 看布局 guidelines）
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
              child: const _ColorfulBox(),
            ),
            // origin: 右上角
            Transform.scale(
              scale: 2.0,
              origin: const Offset(25, -25),
              child: const _ColorfulBox(),
            ),
            // origin：左下角
            Transform.scale(
              scale: 2.0,
              origin: const Offset(-25, 25),
              child: const _ColorfulBox(),
            ),
            // origin: 右下角
            Transform.scale(
              scale: 2.0,
              origin: const Offset(25, 25),
              child: const _ColorfulBox(),
            ),
            // 水平方向放大
            Transform.scale(scaleX: 2, child: const _ColorfulBox()),
            // 垂直方向放大
            Transform.scale(scaleY: 2, child: const _ColorfulBox()),
          ],
        ),
      ),
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
