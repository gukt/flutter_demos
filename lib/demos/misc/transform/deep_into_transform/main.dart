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
/// - [高级 Flutter：Matrix4 和透视变换](https://medium.com/flutter-community/advanced-flutter-matrix4-and-perspective-transformations-a79404a0d828)
/// - [Flutter 透视图](https://medium.com/flutter/perspective-on-flutter-6f832f4d912e)
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            //   Example1(),
            //   Example2(),
            //   Example3(),
            //   Example31(),
            SkewExample1(),
            //   Example4(),
            //   Example4(),
            //   Example4(),
          ],
        ),
      ),
    );
  }
}

class SkewExample1 extends StatelessWidget {
  const SkewExample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Transform 没有提供 skew 相关的命名构造函数，只能通过 Matrix4 来实现.

        // 原始大小，无变换
        Transform(
          transform: Matrix4.identity(),
          child: const _Box(),
        ),
        Transform(
          // 沿 x 轴倾斜，参数为弧度，正数为底部右倾
          // 倾斜时，x 轴上的边长不变
          transform: Matrix4.skewX(45 * math.pi / 180),
          child: const _Box(),
        ),
        Transform(
          // 沿 y 轴倾斜，参数为弧度，正数为右侧下倾，
          // 倾斜时，y 轴上的边长不变
          transform: Matrix4.skewY(45 * math.pi / 180),
          child: const _Box(),
        ),
        const SizedBox(height: 100),
        Transform(
          // 水平方向右斜 45 度，垂直方向下斜 15 度
          // 请打开 Overlay Guidelines 查看实际效果
          transform: Matrix4.skew(45 * math.pi / 180, 15 * math.pi / 180),
          child: const _Box(),
        ),
      ],
    );
  }
}

/// 缩放，同时指定 alignment 和 origin，叠加的效果是坐标原点为 child 右下角
class ScaleExample1 extends StatelessWidget {
  const ScaleExample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform(
          transform: Matrix4.identity()..scale(1.5),
          // origin: const Offset(50, 50),
          // The alignment of the origin, relative to the size of the box.
          // 这相当于根据框的大小设置一个原点。如果它与[origin]同时指定，则两者都将应用。
          // 设定原点相对于盒子的对齐方式，在 Transform 的默认构造函数中如果不设置则默认为 topLeft，即 child 渲染盒子的左上角为坐标原点；Transform.translate 构造函数也是默认 topLeft。而 Transform.scale、Transform.rotated 构造函数如果不指定 alignment 则默认值为 Alignment.center,
          // 注意：如果 alignment 与 origin 同时使用，则两者都生效，具体计算逻辑是：先根据 alignment 定位原点在 child 渲染框中的位置，然后使用 origin 属性指定的 offset 再将坐标原点进行偏移。
          // 本例中 alignment.center 决定了坐标原点在 child 的中心点，然后加上 offset 指定了再将原点向右和向下移动 50（渲染框尺寸为 100），共同决定的结果是坐标原点最终为 child 的右下角
          alignment: Alignment.center,
          origin: const Offset(50, 50),
          child: const _Box(),
        ),
        Transform(
          transform: Matrix4.identity()..scale(2.0, 0.5),
          child: const _Box(),
        ),
      ],
    );
  }
}

/// 使用 Transform.scale 进行缩放
class ScaleExample2 extends StatelessWidget {
  const ScaleExample2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 全方位放大一倍，Transform.scale 的坐标原点为 child 中心点（因为该构造函数设置了 alignment 为 Alignment.center）
        Transform.scale(scale: 2, child: const _Box()),

        // 分别指定 x，y 轴上放大倍数
        Transform.scale(
          scaleX: 0.5,
          scaleY: 2.0,
          child: const _Box(),
        ),
      ],
    );
  }
}

/// 使用 setEntry(row, col, value) 进行缩放
/// (0,0) 决定 x 轴缩放系数
/// (1,1) 决定 y 轴缩放系数
/// (2,2) 决定 z 轴缩放系数（对于 2D 平面，z 轴缩放没意义）
/// (3,3) 决定全方位缩放系数（注意，数值应设置为缩放系数的倒数）
/// 注意：使用 Transform 默认构造函数进行变换时，默认坐标原点为 topLeft
class ScaleExample3 extends StatelessWidget {
  const ScaleExample3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform(
          transform: Matrix4.identity()
            // X 轴放大一倍
            ..setEntry(0, 0, 2)
            // Y 轴缩小一半
            ..setEntry(1, 1, 0.5),
          child: const _Box(),
        ),
        //  全方位缩小一倍 (此处设定的值为放大系数的倒数)
        Transform(
          transform: Matrix4.identity()..setEntry(3, 3, 2),
          child: const _Box(),
        ),
        Transform(
          // scale 用来指定 x，y，z 轴放大系数，如果只指定第一个参数，则表示全方位放大
          // 对于二维平面图，z 轴缩放是没有意义的
          // 第一个参数类型是 dynamic 的，可以指定 double, Vector3, Vector4 三种
          // 注意：如果第一个参数是数值，必须是 double 类型，要加小数点，不然如果被识别成 int 会抛出 UnimplementedError
          transform: Matrix4.identity()..scale(0.5),
          // 设定坐标系的原点位置（默认为渲染对象的左上角），
          // 如果使用默认值，你会看到 box 左上角不变，尺寸向右下角放大
          // 此处设置为 const Offset(50, 50) 表示将坐标原点移动到 child 的中心点（因为 child 的尺寸为 100 * 100），此时你将看到渲染对象以中心点向四周扩散放大
          // 使用 origin 设定坐标原点不然使用 alignment 设定简单，请看 Example3
          origin: const Offset(50, 50),
          child: const _Box(),
        ),
        // 我们知道，缩放是由举证的对角线相关值控制的（见示意图：https://miro.medium.com/max/506/1*JmX0nGtLI2dVBQW6zV0dmg.png）
        // diagonal3， diagonal3Values，setDiagonal 用来设置对角线相关值，使用他们也可以直接进行缩放
        Transform(
          transform: Matrix4.diagonal3(vect.Vector3(2, 0.5, 1.0)),
          child: const _Box(),
        ),
        Transform(
          transform: Matrix4.diagonal3Values(2, 0.5, 1.0),
          child: const _Box(),
        ),
        Transform(
          transform: Matrix4.identity()
            ..setDiagonal(vect.Vector4(2, 0.5, 1.0, 1.0)),
          child: const _Box(),
        ),
      ],
    );
  }
}

/// 旋转。
///
/// 如果你要使用 setEntry 对矩阵相关位置设置进行旋转，请参考如下示意图
///   - 绕 X 轴旋转：https://miro.medium.com/max/812/1*X9U-o3tx-Vn9zGG-m0b9jw.png
///   - 绕 Y 轴旋转：https://miro.medium.com/max/870/1*Bzd2i-f55vCEShJIdLmfWg.png
///   - 绕 Z 轴旋转：https://miro.medium.com/max/974/1*DpbpYNDKljlYemjawkRW1Q.png
/// 对于旋转，最好还是使用 ..rotateX ..rotateY ..rotateZ 或
/// Matrix4.rotationX、Matrix4.rotationY、Matrix4.rotationZ
class RotateExample1 extends StatelessWidget {
  const RotateExample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 原始尺寸
        Transform(
          transform: Matrix4.identity(),
          child: const _Box(),
        ),
        Transform(
          // 围绕 X 轴旋转 45 度（以弧度为单位），视觉上高度会变小
          transform: Matrix4.rotationX(45 * math.pi / 180),
          child: const _Box(),
        ),
        Transform(
          // 围绕 Y 轴旋转，视觉上宽度会变小
          transform: Matrix4.rotationY(45 * math.pi / 180),
          child: const _Box(),
        ),
        Transform(
          // 围绕 Z 轴旋转，视觉上平面图形尺寸不会变好，只是在 X，Y 轴构成的平面上发生了旋转，正数表示顺时针旋转
          transform: Matrix4.rotationZ(45 * math.pi / 180),
          child: const _Box(),
        ),
        Transform(
          // 注意：Transform 默认构造函数构造的实例对象的 alignment 均为 null，则转换应用的坐标原点是 child 渲染框的 topLeft
          transform: Matrix4.rotationZ(45 * math.pi / 180),
          alignment: Alignment.center,
          child: const _Box(),
        ),
        Transform(
          // 注意：Transform 默认构造函数构造的实例对象的 alignment 均为 null，则转换应用的坐标原点是 child 渲染框的 topLeft
          transform: Matrix4.rotationZ(45 * math.pi / 180),
          alignment: Alignment.center,
          origin: const Offset(50, 50),
          child: const _Box(),
        ),
        Transform(
          // 等效于 Matrix4.rotationZ， 类似的还有 rotateX, rotateY
          transform: Matrix4.identity()..rotateZ(45 * math.pi / 180),
          child: const _Box(),
        ),
      ],
    );
  }
}

/// 使用 Transform.rotate 对 child 按中心点旋转（围绕 Z 轴进行旋转）
/// 你可以通过 alignment 和 origin （或叠加）来控制坐标原点
class RotateExample2 extends StatelessWidget {
  const RotateExample2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      // 旋转角度（以弧度为单位）
      angle: 145 * math.pi / 180,
      child: const _Box(),
    );
  }
}

/// 平移。
class TranslateExample1 extends StatelessWidget {
  const TranslateExample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 平移的实现方式有很多种，以下几种都可以
        Transform(
          transform: Matrix4.translationValues(50, 50, 0),
          child: const _Box(),
        ),
        //
        Transform(
          transform: Matrix4.translation(vect.Vector3(50, 50, 0)),
          child: const _Box(),
        ),
        Transform.translate(
          offset: const Offset(50, 50),
          child: const _Box(),
        ),
        // 如果想在 x, y, z 上平移一定的距离，请参考该示意图（https://miro.medium.com/max/538/1*fSgMQg5FEzoBC8MPWrn-iA.png）设置底部的 x, y, z 三个值。 实际调用 setEntry 时将你在图中看到的行列值互换以下就可以（因为 Matrix4 是用列优先填充的，而不是行优先）
        Transform(
          transform: Matrix4.identity()
            // x 轴平移 50
            ..setEntry(0, 3, 50)
            // y 轴平移 50
            ..setEntry(1, 3, 50),
          child: const _Box(),
        ),
      ],
    );
  }
}

/// 透视（深度感知）
///
/// 透视变换就像延伸到远处的铁轨或林荫道的效果，越远就越小
class PerspectiveExmaple1 extends StatelessWidget {
  const PerspectiveExmaple1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform(
          transform: Matrix4.identity()
            // Z 轴透视
            ..setEntry(3, 2, 0.001)
            ..rotateX(-60 * math.pi / 180)
            ..scale(2.0),
          alignment: Alignment.center,
          child: const _Box(),
        ),
        Transform(
          transform: Matrix4.identity()
            // X 轴透视
            ..setEntry(3, 0, 0.001)
            ..rotateX(-60 * math.pi / 180)
            ..scale(2.0),
          alignment: Alignment.center,
          child: const _Box(),
        ),
        Transform(
          transform: Matrix4.identity()
            // Y 轴透视
            ..setEntry(3, 1, 0.001)
            ..rotateX(-60 * math.pi / 180)
            ..scale(2.0),
          alignment: Alignment.center,
          child: const _Box(),
        ),
      ],
    );
  }
}

/// 透视（深度感知）。
///
/// 可以设置 alignment 和旋转方向，并且可以响应拖动时实时展现透视效果。
class PerspectiveExmaple2 extends StatelessWidget {
  const PerspectiveExmaple2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Offset offset = Offset.zero;
    Alignment? alignment = Alignment.center;
    // 0: 绕 x 轴旋转，1：绕 y 轴旋转，2：both
    int? rotateMode = 2;

    // 本实例就没有定义一个 StatefulWidget 了，而是使用 StatefulBuilder 实现状态的变更
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        Matrix4 matrix = Matrix4.identity()
          // 设定在 Z 方向启用深度感知
          // 需要改变矩阵中的这个值（见示意图：https://miro.medium.com/max/672/1*2IYCQ8NCQydB_0G2NmrpgQ.png），
          // 强烈注意：由图可知，我们应该改变第 2 行，第 3 列的值（以 0 为基数），但是由于 Flutter 中的 Matrix4 是列优先填充的，所以实际写代码时要将示意图中看到的行列数值互换就可以了
          ..setEntry(3, 2, 0.001);
        // 根据设定的旋转模式（rotateMode）设置旋转变换
        if (rotateMode == 0 || rotateMode == 2) {
          // 设定绕 x 轴旋转，
          // 一度等于 π / 180 = 0.017444 左右
          // 所以，如果一定移动 200 像素距离大概相当于 114 度左右
          // 如何确定 X 轴顺时针旋转的方向？
          // 把你的手机屏幕想象成一个立体的砖头，从左侧看你的手机在 X 轴上顺时针旋转的样子，表现在屏幕上 2D 渲染框就是上面向外，下面向内旋转（假设以中心点旋转）
          matrix.rotateX(0.01 * offset.dy);
        }
        if (rotateMode == 1 || rotateMode == 2) {
          // 如果为正数，表示绕 Y 轴顺时针选中，
          //
          // 如何确定 Y 轴顺时针旋转方向？
          // 把你的手机屏幕想象成一个立体的砖头，从顶部看你的手机在 Y 轴上顺时针旋转的样子，表现在屏幕上 2D 渲染框就是左侧向内，右侧向外旋转（假设以中心点旋转）
          //
          // 如果向右移动，dx 增加，乘以 -0.01 表示方向取反，
          matrix.rotateY(-0.01 * offset.dx);
        }
        return Transform(
            transform: matrix,
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text('中心点：'),
                      Radio(
                        value: Alignment.topLeft,
                        groupValue: alignment,
                        onChanged: (Alignment? value) {
                          setState(() => alignment = value);
                        },
                      ),
                      const Text('左上'),
                      Radio(
                        value: Alignment.topRight,
                        groupValue: alignment,
                        onChanged: (Alignment? value) {
                          setState(() => alignment = value);
                        },
                      ),
                      const Text('右上'),
                      Radio(
                        value: Alignment.center,
                        groupValue: alignment,
                        onChanged: (Alignment? value) {
                          setState(() => alignment = value);
                        },
                      ),
                      const Text('中心'),
                      Radio(
                        value: Alignment.bottomLeft,
                        groupValue: alignment,
                        onChanged: (Alignment? value) {
                          setState(() => alignment = value);
                        },
                      ),
                      const Text('左下'),
                      Radio(
                        value: Alignment.bottomRight,
                        groupValue: alignment,
                        onChanged: (Alignment? value) {
                          setState(() => alignment = value);
                        },
                      ),
                      const Text('右下'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('旋转：'),
                      Radio(
                        value: 0,
                        groupValue: rotateMode,
                        onChanged: (int? value) {
                          setState(() => rotateMode = value);
                        },
                      ),
                      const Text('仅 X 轴'),
                      Radio(
                        value: 1,
                        groupValue: rotateMode,
                        onChanged: (int? value) {
                          setState(() => rotateMode = value);
                        },
                      ),
                      const Text('仅 Y 轴'),
                      Radio(
                        value: 2,
                        groupValue: rotateMode,
                        onChanged: (int? value) {
                          setState(() => rotateMode = value);
                        },
                      ),
                      const Text('X，Y 轴'),
                    ],
                  ),
                  // 响应手势
                  GestureDetector(
                    // 拖动更新，每次移动时都会触发
                    onPanUpdate: (DragUpdateDetails details) {
                      // details.delta 中包含每次移动的距离，因为会触发很多次，所以每次数值可能比较小，如果移动的较快，则 delta 数值会比较大，如果下一个点在上一个点的右边，则 dx 为正数，同理，如果在下面 dy 也是正数；反之负数。
                      // 将 offset 累加起来
                      setState(() => offset += details.delta);
                      // // 如果从 child 左上角移到右下角，则累加的 dx 应该等于宽度，dy 应该等于高度
                      debugPrint('offset: $offset');
                    },
                    onPanDown: (DragDownDetails details) {
                      // DragDownDetails.toString() 默认输出的是 globalPosition
                      // globalPosition 是相对于屏幕的坐标
                      debugPrint(
                          'onPanDown details: $details, localPosition: ${details.localPosition}');
                    },
                    // 双击重置 offset
                    onDoubleTap: () => setState(() => offset = Offset.zero),
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      // color: Colors.blue,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.amber,
          Colors.pink,
        ]),
      ),
    );
  }
}
