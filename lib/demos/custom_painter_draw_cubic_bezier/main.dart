import 'package:flutter/material.dart';
import 'dart:math';

///
/// See also:
/// * https://medium.com/flutter-community/paths-in-flutter-a-visual-guide-6c906464dcd0 这篇文章对 Flutter Path、CustomPainter、贝塞尔曲线等做了非常详细的说明
/// * https://api.flutter.dev/flutter/dart-ui/Path-class.html
/// * [贝塞尔曲线(cubic-bezier) SVG代码生成器](http://jsrun.net/app/bezier)，这个在线工具虽然是用于生成 SVG 的，但也可以帮助我们可视化的看到实时拖动点的定位后曲线的变化情况。
/// * [Flutter Path(二) ： Path 进阶](https://juejin.cn/post/6844904152829558797)
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CubicBezierPathPainter(),
    );
  }
}

// 三次贝塞尔曲线 Painter:
// 演示图：https://miro.medium.com/max/720/1*RdNctOG0RlAfzvrAez2rVQ.gif
class CubicBezierPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    // 三次贝塞尔曲线需要三个字段，加上原点，所以我们需要定义另外三个点才能形成三条线段
    // 第一个点：1/4 width, 3/4 height
    // 第二个点：3/4 width, 1/4 height
    // 第三个点：屏幕右下角
    path.cubicTo(size.width / 4, 3 * size.height / 4, 3 * size.width / 4,
        size.height / 4, size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
