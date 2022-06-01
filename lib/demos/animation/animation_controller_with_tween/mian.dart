import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();

    // 实例化 AnimationController，后面会将他传给 Tween 对象使用
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    // Tween 是一个泛型类，继承自 Animatable<T>，而不是 Animation<T>
    // animate 方法是定义在 Animatable 上的，用以指定该 Tween 受那个 Animation 对象驱动（AnimationController 是一个特殊的 Animation）
    animation = Tween<double>(begin: 100, end: 300).animate(animationController)
      // Animation<T> 是一个 Listenable 对象，所以它可以添加监听器
      // 这里我们添加监听器，当值发生变化是调用 setState() 将当前帧标记为'脏'状态，
      // 以便下一帧会重新 build
      ..addListener(() {
        setState(() {});
      });
    // 开始动画（正向）
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: animation.value,
          height: animation.value,
          color: Colors.amber,
        ),
      ),
    );
  }
}
