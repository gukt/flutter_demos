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
      painter: PathPainter(),
    );
  }
}

// 自定义 Painter, 画一条从屏幕左上角到右下角的对角线
class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 首先要创建一个 Paint 对象，并指定划线的颜色、策略、线宽
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = Path();
    path.lineTo(size.width, size.height);
    // 在 Canvas 上绘制
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
