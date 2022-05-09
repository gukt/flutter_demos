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

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PathPainter2 extends CustomPainter {
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

// ConicTo 贝塞尔曲线 Painter
// 可以画双曲线、抛物线、椭圆
class ConicBezierPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    // conicTo 基本上像一个二次 beizer，唯一的区别是权重变量
    // 添加一个 bezier 线段，利用控制点(x1,y1)和权值 w，从当前点曲线到给定点(x2,y2)。
    // 如果权重大于 1，则曲线为双曲线;
    // 如果权重等于 1，它是一条抛物线;
    // 如果权重小于 1，它就是椭圆。
    //
    // 第一个点：1/4 width, 3/4 height
    // 第二个点：屏幕右下角
    // 你可以尝试更改最后一个参数 w 试试看效果。
    path.conicTo(
        size.width / 4, 3 * size.height / 4, size.width, size.height, 1.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
