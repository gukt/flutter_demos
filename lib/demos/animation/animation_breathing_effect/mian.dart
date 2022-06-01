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

    // 以下这段代码实现呼吸效果，所谓呼吸效果就是：正向-方向-正向-反向...如此循环
    // AnimationController 刚刚实例化还没启动时，其状态是 dismissed
    // forward() 执行后到 upperBound 时，状态为 completed
    // reverse() 表示反向运行
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
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
