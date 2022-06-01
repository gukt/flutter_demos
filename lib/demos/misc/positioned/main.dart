import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.amber,
          // 这里的 Stack 空间大小由父级的 Container 决定的
          child: Stack(children: [
            // Positioned 必须放在 Stack 内
            // 仅可以设置 6 个属性：
            // 水平方向：left, right, width
            // 垂直方向：top, bottom, height
            // 水平和垂直方向中的三个值分别都只能设置两个，否则冲突
            // 如果不设置 width，height，则具体大小由 child 决定
            Positioned(
              left: 50,
              top: 50,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.pink,
              ),
            ),
            // 如果设置了 width，height，则 child 不能决定自己的大小
            // 这里设置 left 和 bottom
            Positioned(
              left: 50,
              bottom: 10,
              width: 100,
              height: 80,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.green,
              ),
            ),
            // 如果使用 directional 构造函数，则 left，right 属性没有了，取而代之的是 start，end，而 start，end 的方向是有 textDirection 属性值决定的
            Positioned.directional(
              start: 10,
              textDirection: TextDirection.rtl,
              child: const Text('Hello world'),
            ),
            // fill 是一个特例，它指定 child 将完全填充满 stack 的空间（left，right，top，bottom 默认均为 0，当然你也可以针对每一个属性值进行调整）
            const Positioned.fill(
              child: FlutterLogo(),
            ),
            // 通过一个矩形来设置位置，矩形坐标相对于 Stack
            // fromRect 内部是设置了 Positioned 的 LTWH（见构造函数）
            // 以下四种方式创建的 Rect 实例都是等效的：
            // rect: const Rect.fromLTRB(10, 10, 20, 20),
            // rect: const Rect.fromLTWH(10, 10, 10, 10),
            // rect: Rect.fromCenter(
            //   center: const Offset(15, 15),
            //   width: 10,
            //   height: 10,
            // ),
            // rect: Rect.fromCircle(center: const Offset(15, 15), radius: 5),
            Positioned.fromRect(
              // 以下四种方式创建的 Rect 实例都是等效的
              rect: const Rect.fromLTRB(10, 10, 20, 20),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
              ),
            ),
            // RelativeRect 表示相对矩形，它只是定义了它和其他容器四条表之间的相对距离（和 Positioned 相对于 Stack 概念类似），他的大小是不确定的，取决于它相对于那个父级容器。
            // 而 Rect 定义了矩形的 LTRB 四个点（左上角和右下角可以唯一确定一个矩形），这个矩形的大小是确定的。LTBR 的值取决于其相对坐标原点，坐标原点不同得到的 LTRB 是不同的，但是它的大小是确定的。
            Positioned.fromRelativeRect(
              // 这里通过设定具体的 LTRB 的距离构建 RelativeRect
              rect: const RelativeRect.fromLTRB(20, 20, 20, 170),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
