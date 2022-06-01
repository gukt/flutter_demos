import 'package:flutter/material.dart';
import 'dart:math' as math;

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
            // 将 child 在 x 轴及 y 轴上平移 offset 指定的量
            Transform.translate(
              // Offset(25, 25) 表示 x 轴向右移动 25，y 轴向下移动 25
              offset: const Offset(25, 25),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
