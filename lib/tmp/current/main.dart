import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vect;

/// 深入了解 Matrix4 演示
///
/// 请打开 Widget Inspector 中的 Overlay Guidlines 观察各个实例效果
///
/// 尽管 Matirx4 称为 4D 矩阵这个名字比较酷，但实际上它就是一个 4*4 的矩阵: https://miro.medium.com/max/636/1*Y8M0YmRxrLARm8-nTEmCjA.png
///
/// **特别注意 🔥🔥🔥：如果我们参考上文中的矩阵示意图得到相关行列值，在实际使用 Matrix4.setEntry(row, col, value) 时，要将文中看到的行列值互换一下填到 setEntry(...) 方法里，因为 Flutter 的 Matrix4 是以列优先填充矩阵的。**
///
/// Transform 是一个功能非常强大的 Widget， 它可以使我们能够从根本上改变小部件的外观和行为方式，从而使我们能够创建新的、复杂的动画类型。
///
/// 虽然 Transform 提供了几个便利的常量构造函数 Transform.scale、Transform.rotate、Transform.translate 来进行缩放、旋转、平移等操作，但如果直接使用 Transform 的默认构造函数并指定 Matrix4，可以让我们创造成更多更棒的效果，比如 3D 透视变换。
///
/// See also:
/// - [Make 3D flip animation in Flutter](https://medium.com/flutter-community/make-3d-flip-animation-in-flutter-16c006bb3798)
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // ClipRect(
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //     heightFactor: 0.5,
            //     child: _Card(),
            //   ),
            // ),
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.00)
                ..rotateX(math.pi / 4),
              alignment: Alignment.bottomCenter,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  // 设置 Align 的高度是 child 高度的一半
                  heightFactor: 0.5,
                  child: _Card(),
                ),
              ),
            ),
            SizedBox(height: 5),
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(-45 * math.pi / 180),
              alignment: Alignment.topCenter,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  // 设置 Align 的高度是 child 高度的一半
                  heightFactor: 0.5,
                  child: _Card(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: Text(
          '1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 250,
          ),
        ),
      ),
    );
  }
}
