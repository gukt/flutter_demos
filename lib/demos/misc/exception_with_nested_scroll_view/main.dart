import 'package:flutter/material.dart';

/// 这里演示一个错误的例子，将一个 ScrollView 嵌套在另一个 ScrollView 中
/// 本例中是将 ListView 嵌入在 SingleChildScrollView 中
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const Text('Hello'),
          const Text('Flutter'),
          // 在 SingleChildScrollView 中嵌套了另一个 ScrollView(ListView) 将会抛出错误：Vertical viewport was given unbounded height.
          // 提示：...This situation typically happens when a scrollable widget is nested inside another scrollable widget...
          ListView(
            children: const [
              Text('Hello'),
              Text('Flutter'),
            ],
          )
        ]),
      ),
    );
  }
}
