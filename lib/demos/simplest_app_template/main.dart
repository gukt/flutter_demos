import 'package:flutter/material.dart';

/// 示例：一个最简单 App 应用
///
/// main 函数是 app 的主入口，
/// 如果想要接受命令行参数，可以给 main 函数添加 `List<String> args` 参数
///
/// 理论上来说没有比只有一个 main 函数更少代码的 App 了。
/// 运行看看在浏览器看看吧？
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Hello Flutter')));
  }
}
