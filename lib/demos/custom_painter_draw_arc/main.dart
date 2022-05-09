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
      painter: ArcPathPainter(),
    );
  }
}

class ArcPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    // 定义一个将角度转换为弧度的方法（degree to radians）
    double degToRad(num deg) => deg * (pi / 180.0);
    Path path = Path();
    // arcTo 接受一个椭圆，得到一个起始角和扫描角作为弧度。它从起始角开始绘制椭圆，并将扫描角添加到起始角。
    // 例如，从椭圆的左中边缘到上边缘绘制圆弧，我们将从 0(0的弧度值)开始，加上 1.57(90的弧度值)。
    // 第一个参数：Rect 类型，定义一个矩形，此例中定义的矩形左上角是屏幕中心，宽度为 1/4 屏幕，高度为 1/4 高度
    // 第二个参数：起始角弧度（startAngle）
    // 第三个参数：扫描角弧度（sweepAngle）
    // 第四个参数：forceMoveTo,
    path.arcTo(
        Rect.fromLTWH(
            size.width / 2, size.height / 2, size.width / 4, size.height / 4),
        degToRad(0),
        degToRad(90),
        true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
