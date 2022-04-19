import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;
  late VoidCallback _incrementer;

  @override
  void initState() {
    super.initState();

    _incrementer = () {
      setState(() {
        count++;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    // 输出 count 可以看出是不断递增的,也就是说, MyApp Widget 实例是每次重新构建的, 但 state 实例并不变, 所以 widget 的状态可以保持连续.
    debugPrint('MyApp is building: count:$count');
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: SharingDataWidget(
            count: count,
            child: Column(
              children: [
                const WidgetA1(),
                const WidgetB(),
                WidgetC(onTap: _incrementer),
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
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  final int count;
  const WidgetA({Key? key, this.count = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building Widget A');
    return Text('$count');
  }
}

// WidgetA 中需要的状态数据是需要在构造实例时传入, 这个类是一个变体,
// 使用了 SharingDataWidget 中的数据, 因此就不用在构造函数中传值了.
class WidgetA1 extends StatefulWidget {
  const WidgetA1({Key? key}) : super(key: key);

  @override
  State<WidgetA1> createState() => _WidgetA1State();
}

class _WidgetA1State extends State<WidgetA1> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Building Widget A1');
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

class WidgetB extends StatelessWidget {
  const WidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building Widget B');
    return const Text('I am Widget B');
  }
}

class WidgetC extends StatelessWidget {
  final VoidCallback onTap;
  const WidgetC({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Building Widget C');
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
