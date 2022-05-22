import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vect;

/// 深入了解 Matrix4 演示
///
/// 尽管 Matirx4 称为 4D 矩阵这个名字比较酷，但实际上它就是一个 4*4 的矩阵: https://miro.medium.com/max/636/1*Y8M0YmRxrLARm8-nTEmCjA.png
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
            PerspectiveExmaple2(),
            //   Example4(),
            //   Example4(),
            //   Example4(),
          ],
        ),
      ),
    );
  }
}

/// 指定 tranform 为 Matrix4.identity()（默认矩阵），对 child 不做任何变换
class ExampleNotTransformed extends StatelessWidget {
  const ExampleNotTransformed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      // Matrix4.identity() 设置矩阵为：
      //  1, 0, 0, 0,
      //  0, 1, 0, 0,
      //  0, 0, 1, 0,
      //  0, 0, 0, 1
      // 上面的矩阵称为单位矩阵，这个矩阵右下对角线上的值为 1，其他均为 0。
      // 在这个矩阵中使用不同的数字组合，我们可以操纵给定对象的形状、大小、方向等。
      transform: Matrix4.identity(),
      child: const _Box(),
    );
  }
}

/// 将 child 在 x，y，z 轴上全方位放大 2 倍，并设定坐标原点为 child 中心点
class ScaleExample0 extends StatelessWidget {
  const ScaleExample0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      // scale 用来指定 x，y，z 轴放大系数，如果只指定第一个参数，则表示全方位放大
      // 对于二维平面图，z 轴缩放是没有意义的
      // 第一个参数类型是 dynamic 的，可以指定 double, Vector3, Vector4 三种
      // 注意：如果第一个参数是数值，必须是 double 类型，要加小数点，不然如果被识别成 int 会抛出 UnimplementedError
      transform: Matrix4.identity()..scale(2.0),
      // 设定坐标系的原点位置（默认为渲染对象的左上角），
      // 如果使用默认值，你会看到 box 左上角不变，尺寸向右下角放大
      // 此处设置为 const Offset(50, 50) 表示将坐标原点移动到 child 的中心点（因为 child 的尺寸为 100 * 100），此时你将看到渲染对象以中心点向四周扩散放大
      // 使用 origin 设定坐标原点不然使用 alignment 设定简单，请看 Example3
      origin: const Offset(50, 50),
      child: const _Box(),
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
        // X 轴放大一倍
        Transform(
          transform: Matrix4.identity()..setEntry(0, 0, 2),
          child: const _Box(),
        ),
        // Y 轴缩小一半
        Transform(
          transform: Matrix4.identity()..setEntry(1, 1, 0.5),
          child: const _Box(),
        ),
        //  全方位放大一倍 (此处设定的值为放大系数的倒数)
        Transform(
          transform: Matrix4.identity()..setEntry(3, 3, 0.5),
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

/// TODO
/// - 平移：矩阵第 4 行，从左到右分别控制沿 x、y、z 轴平移的距离，例如：
///   - ..setEntry(3, 0, 50) - 沿 X 轴右移 50（负数表示左移）
///   - ..setEntry(3, 1, 50) - 沿 Y 轴右移 50（负数表示上移）
class TranslateExample1 extends StatelessWidget {
  const TranslateExample1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform(
          transform: Matrix4.translationValues(50, 50, 0),
          child: const _Box(),
        ),
        Transform(
          transform: Matrix4.translation(vect.Vector3(50, 50, 0)),
          child: const _Box(),
        ),
        Transform.translate(
          offset: const Offset(50, 50),
          child: const _Box(),
        ),
        // 矩阵中的第 3 行（以 0 开始），从左到右分别控制沿 x、y、z 轴平移的距离，示意图：https://miro.medium.com/max/538/1*fSgMQg5FEzoBC8MPWrn-iA.png
        Transform(
          transform: Matrix4.identity()
            ..setEntry(0, 3, 50)
            ..setEntry(1, 3, 50),
          alignment: Alignment.center,
          child: const _Box(),
        ),
      ],
    );
  }
}

class TranslateExample2 extends StatelessWidget {
  const TranslateExample2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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

/// 透视。可以设置 alignment 和旋转方向，并且可以响应拖动时实时展现透视效果。
class PerspectiveExmaple2 extends StatelessWidget {
  const PerspectiveExmaple2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Offset offset = Offset.zero;
    Alignment? alignment = Alignment.topLeft;
    // 0: 绕 x 轴旋转，1：绕 y 轴旋转，2：both
    int? rotateMode = 0;

    // 本实例就没有定义一个 StatefulWidget 了，而是使用 StatefulBuilder 实现状态的变更
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        Matrix4 matrix = Matrix4.identity()
          // 设定在 Z 方向启用深度感知
          ..setEntry(3, 2, 0.001);
        // 根据设定的旋转模式（rotateMode）设置旋转变换
        if (rotateMode == 0 || rotateMode == 2) {
          matrix.rotateX(0.01 * offset.dy);
        }
        if (rotateMode == 1 || rotateMode == 2) {
          matrix.rotateY(-0.01 * offset.dx);
        }
        return Transform(
            transform: matrix,
            alignment: alignment,
            child: Column(
              children: [
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                ),
                // 响应手势
                GestureDetector(
                  // 拖动更新
                  onPanUpdate: (DragUpdateDetails details) {
                    debugPrint('onPanUpdate delta: ${details.delta}');
                    // setState(() => offset += details.delta);
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
            ));
      },
    );
  }
}

class Example5 extends StatefulWidget {
  const Example5({Key? key}) : super(key: key);

  @override
  State<Example5> createState() => _Example5State();
}

class _Example5State extends State<Example5> {
  double x = 0 * math.pi / 180;
  double y = 0 * math.pi / 180;
  double z = 0 * math.pi / 180;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity(),
      // 将变换的中心设置为 child 的中心
      alignment: Alignment.center,
      child: GestureDetector(
        onPanUpdate: (details) {
          debugPrint('details: $details');
          setState(() {
            y = y - details.delta.dx / 100;
            x = x + details.delta.dy / 100;
          });
        },
        child: const _Box(),
      ),
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
