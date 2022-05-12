import 'package:flutter/material.dart';

/// https://medium.com/flutter-community/advanced-flutter-matrix4-and-perspective-transformations-a79404a0d828
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double x = 60 * 3.14 / 180;
  double y = 0;
  double z = 45 * 3.14 / 180;

  @override
  Widget build(BuildContext context) {
    x = 0;
    y = 0;
    z = 0;
    return Scaffold(
      body: Center(
        child: Transform(
          // 这里自动格式化比较讨厌，所以将 4*4 矩阵写在注释里，便于阅读
          // 1,0,0,0,
          // 0,1,0,0,
          // 0,0,1,0,
          // 0,0,0,1
          // 这种称之为恒等矩阵（Identify Matrix）
          // 可以使用 Matrix.identity() 来构造
          transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          // 将变换的中心设置为正方形的中心
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                y = y - details.delta.dx / 100;
                x = x + details.delta.dy / 100;
              });
            },
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.amber,
                  Colors.pink,
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
