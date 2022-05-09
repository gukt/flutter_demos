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
      painter: QuadraticBezierPathPainter(),
    );
  }
}

// 二次贝塞尔曲线 Painter
// 演示图：https://miro.medium.com/max/720/1*5AFlx8TQWduMkT2uzzN9hQ.gif
class QuadraticBezierPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    // 起始点设为屏幕最左边的中心点
    path.moveTo(0, size.height / 2);
    // 设定二次贝塞尔曲线的另外两个点，这样就会得到两条线段
    // 第一个点：屏幕底部中心点，由第 1，2 个参数决定
    // 第二个点：屏幕右边中心点，由第 3，4 个参数决定
    // 最终会形成一条由屏幕左边线中点开始，到屏幕右边线中点结束，并向屏幕底部弯曲的一条贝塞尔曲线
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
