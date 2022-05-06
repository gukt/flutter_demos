import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;
  late VoidCallback _increment;

  @override
  void initState() {
    super.initState();

    _increment = () {
      setState(() => _count++);
    };
  }

  @override
  Widget build(BuildContext context) {
    // 可以看出打印的 count 是不断递增的,也就是说, 实例是每次重新构建的,
    // 但 state 实例并不变, 所以 widget 的状态可以保持连续.
    debugPrint('Count: $_count');
    return Scaffold(
      appBar: AppBar(title: const Text('Count demo')),
      body: Center(
        child: SharingDataWidget(
          count: _count,
          child: Column(
            children: [
              const Widget3(),
              const Widget2(),
              WidgetC(onTap: _increment),
            ],
          ),
        ),
        // child: Column(
        //   children: [
        //     WidgetA(
        //       count: _count,
        //     ),
        //     WidgetB(),
        //     WidgetC(
        //       onTap: () {
        //         setState(() {
        //           _count++;
        //         });
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  final int count;
  const WidgetA({Key? key, this.count = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building: Widget A');
    return Text('$count');
  }
}

// WidgetA 中需要的状态数据是需要在构造实例时传入, 这个类是一个变体,
// 使用了 SharingDataWidget 中的数据, 因此就不用在构造函数中传值了.
class Widget3 extends StatefulWidget {
  const Widget3({Key? key}) : super(key: key);

  @override
  State<Widget3> createState() => _Widget3State();
}

class _Widget3State extends State<Widget3> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Building: Widget3');
    // 这里显示的值改为从 SharingDataWidget 中获取了,
    // 换句话说: WidgetA1 依赖于 SharingDataWidget
    // 如果 SharingDataWidget 的 updateShouldNotify 强制返回 false 表示不通知依赖的 widget, 则这里的值会永远保持旧的, 尽管 SharingDataWidget 实例的最新值已经更新了,
    return const Text('aaa');
    return Text(SharingDataWidget.of(context)!.count.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies invoked');
  }
}

class Widget2 extends StatelessWidget {
  const Widget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building: Widget B');
    return const Text('Widget B');
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    debugPrint('Building: Widget C');
    return TextButton(
      onPressed: onTap,
      child: const Text('Count'),
    );
  }
}

class SharingDataWidget extends InheritedWidget {
  // NOTE: 这里的 count 是 finla 的,
  // 也就是说, 外部不能直接对它进行更改, 只能由它所在的父 Widget 重新构建
  final int count;

  const SharingDataWidget({
    Key? key,
    this.count = 0,
    required Widget child,
  }) : super(key: key, child: child);

  //定义一个便捷方法，方便子树中的 widget 获取共享数据
  static SharingDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharingDataWidget>();
  }

  @override
  bool updateShouldNotify(SharingDataWidget oldWidget) {
    debugPrint(
        'updateShouldNotify invokded: current: $count, old: ${oldWidget.count}');
    // TODO 可以这就用 false 来阻止通知依赖的 widgets
    // 这样,
    // return false;
    return oldWidget.count != count;
  }
}
