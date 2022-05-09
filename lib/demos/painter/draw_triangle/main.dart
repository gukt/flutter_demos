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
      painter: TrianglePainter(),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    // 移动开始点到屏幕最中心（左上角为原点，水平向右为 x 轴，垂直向下为 Y 轴）
    path.moveTo(size.width / 2, size.height / 2);
    // 从中心点划线到屏幕右下角
    path.lineTo(size.width, size.height);
    path.lineTo(100, 500);
    // close 表示将最后一个点画到起点闭合起来
    // 此例闭合会得到一个三角形，不闭合就是前面绘制的两条线段
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
