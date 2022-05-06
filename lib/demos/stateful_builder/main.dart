import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 这里打印一些数据，用来看按钮点击后 Home Widget 是否被重建了
    // 因为 Home 类是 StatefulWidget, 他是不可变的，也不会在每次按钮点击后被重建
    debugPrint('Home is building...');
    int count = 0;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 这里的 count 是第一次 build 时候读取的，所以会一只保持初始状态值 0
            Text('$count'),
            // 查看代码可见，它的实现非常简单，是一个 StatefulWidget，接受一个 builder
            // 而在它的 State.build() 中，就用这个 builder 来构建 Widget 并返回。
            StatefulBuilder(
              builder: (context, setState) {
                return ElevatedButton(
                  onPressed: () {
                    // 闭包内可以读取外部变量值，
                    // 所以这里可以对外部变量 count 进行读写
                    setState(() => count++);
                  },
                  // 这里的值会在每次点击后增加 1
                  child: Text('$count'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
