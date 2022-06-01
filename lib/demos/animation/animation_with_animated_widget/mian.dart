import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(animationController);
    // NOTE：本例我们需要动画表现的 Widget 继承自 AnimatedWidget，
    // 所以这里不用再像我们经常看到的那样添加监听器，且在监听器里调用 setState() 方法了。
    // 实际上 AnimatedWidget 内部逻辑很简单，只是将 addListener 进行了简单封装
    // 被注释的代码如下：
    // animationController.addListener(() {
    //   setState(() {});
    // });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_HomeState is building...');
    return Center(
      child: AnimatedLogo(animation: animation),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  // AnimatedWidget 的构造函数中接受的是 Lstenable 对象，常见的 Listenable 对象有 Animation 和 ChangeNotifier
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // listenable 是定义在 AnimatedWidget 中的 Listenable 类型，
    // 此类中传入的 Animation<double> 是 Listenable 的，所以这里可以转换。
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}
