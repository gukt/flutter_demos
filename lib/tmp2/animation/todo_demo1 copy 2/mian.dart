import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ChartPage()));
}

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  ChartPageState createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> with TickerProviderStateMixin {
  final random = Random();
  int dataSet = 50;
  late AnimationController animation;
  late double startHeight; // Strike one.
  late double currentHeight; // Strike two.
  late double endHeight;
  late Tween<double> tween;

  @override
  void initState() {
    super.initState();

    startHeight = 0.0;
    endHeight = dataSet.toDouble();
    currentHeight = 0.0;

    // 设置动画控制器，没有指定 lowerBound, UpperBound 参数则使用默认值 0-1
    animation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween = Tween<double>(begin: 0.0, end: dataSet.toDouble());
    // 添加监听器，当值发生变化时回调
    animation.addListener(() {
      setState(() {
        // 当 animation 值发生变化时，通过插值计算获得一个当前值，并记录下来
        // 因为下一次计算插值时起始值会从这个当前值开始
        currentHeight = lerpDouble(
          startHeight,
          endHeight,
          // 推断系数，animation.value 值会在 300 毫秒内从 0 变化到 1
          animation.value,
        )!;
      });
    });

    // 初始后的 AnimationController 并没有启动
    // forward() 表示让控制器正向前进（lowerBound -> UpperBound）
    animation.forward();
  }

  @override
  void dispose() {
    // AnimationController 不用时要及时释放
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      // startHeight = currentHeight;
      // dataSet = random.nextInt(100);
      // endHeight = dataSet.toDouble();
      // animation.forward(from: 0.0);

      dataSet = random.nextInt(100);
      tween = Tween<double>(
        // 以动画结束时的值作为下一个动画的开始值
        begin: tween.evaluate(animation),
        end: dataSet.toDouble(),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: const Size(200.0, 100.0),
          painter: BarChartPainter(tween.animate(animation)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: changeData,
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  const BarChartPainter(this.animation);
  static const barWidth = 10.0;
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final barHeight = animation.value;
    final paint = Paint()
      ..color = Colors.blue[400]!
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - barWidth) / 2.0,
        size.height - barHeight,
        barWidth,
        barHeight,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant BarChartPainter oldDelegate) => false;
}
