import 'package:flutter/material.dart';

/// https://medium.com/flutter/perspective-on-flutter-6f832f4d912e
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  Offset _offset = const Offset(0.4, 0.7); // new

  @override
  Widget build(BuildContext context) {
    return Transform(
      // Transform使用一个3D变换矩阵，它是一个Matrix4。为什么是3D矩阵?Flutter不是做二维图形的吗?
      // 除了功能最弱的智能手机，几乎所有的智能手机都配备了速度惊人的gpu，这些gpu针对3D图像进行了优化。这意味着3D图形的渲染非常快。因此，你在手机上看到的几乎所有东西都是3D渲染的，甚至是2D的东西。疯了,嗯?
      // 设置转换矩阵可以让我们操作正在观看的内容(甚至是3D !)常见的转换包括平移、旋转、缩放和透视。为了创建这个矩阵，我们从一个单位矩阵开始(第40行)，然后对它应用变换。变换不是可交换的，所以我们必须按照正确的顺序应用它们。最终的完整矩阵将被发送给GPU来转换被渲染的对象。
      // 第一个转换(在第41行)实现了透视图。透视使远处的物体显得更小。将矩阵的第3行第2列设置为0.001，根据它们的距离将它们缩小。
      // 0.001这个数字从何而来?稀薄的空气!你可以使用这个数字来增加和减少视角的数量，就像在相机上使用变焦镜头进行放大和缩小一样。这个数字越大，透视就越明显，这让你看起来更接近被观察的对象。
// Flutter 确实提供了makePerspectiveMatrix函数，但该方法包含了设置纵横比、视场、近面和远面(aspect ratio, field of view, and near and far planes )的参数—远远超出了我们的需要—因此我们将直接设置矩阵所需的元素。

      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(_offset.dy)
        ..rotateY(_offset.dx),
      alignment: FractionalOffset.center,
      child: GestureDetector(
        onPanUpdate: (details) => setState(() => _offset += details.delta),
        onDoubleTap: () => setState(() => _offset = Offset.zero),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('The Matrix 3D'),
          ),
          body: Center(
            child: Text('You have pushed the button $_counter times.'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() => _counter++),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
