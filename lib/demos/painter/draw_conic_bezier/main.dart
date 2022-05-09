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
      painter: ConicBezierPathPainter(),
    );
  }
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
