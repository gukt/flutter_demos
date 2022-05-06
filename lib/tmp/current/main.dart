import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    // 可以看出打印的 count 是不断递增的,也就是说, 实例是每次重新构建的,
    // 但 state 实例并不变, 所以 widget 的状态可以保持连续.
    debugPrint('[_HomeState] _count = $_count');
    return Scaffold(
      body: Center(
        child: SharingDataWidget(
          count: _count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Widget1(),
              Widget2(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 设置 _HomeState 里的 _count 变量会导致 _HomeState 重建，
          // 重建时会重新实例化一个新的  SharingDataWidget 实例，
          // 当 flutter 在用新的 SharingDataWidget 实例替换旧实例时，会触发 InheritedWidget 内部的 updateShouldNotify 方法，
          // 而 SharingDataWidget 覆写了 updateShouldNotify 方法，判断如果新旧实例上的 count 变量值发生了更改就通知所有依赖该 SharingDataWidget 节点的子节点
          setState(() => _count++);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Widget1 extends StatefulWidget {
  const Widget1({Key? key}) : super(key: key);

  @override
  _Widget1State createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Widget1 is building...');
    // 这里显示的文本内容是依赖于 SharingDataWidget 中的 count，所以当 SharingDataWidget 中数值发生变更时，Flutter 会通知该 Widget 重建。
    return Center(child: Text('${SharingDataWidget.of(context)!.count}'));
  }

// 当该 State 对象的依赖项发生变更时调用，
// 比如：如果之前的 build 内部引用了一个 InheritedWidget，当 InheritedWidget 发生更改后，框架将会调用该方法
// 该方法也会在 initState 方法调用之后立即调用，
// 在该方法内部调用 BuildContext.dependOnInheritedWidgetOfExactType 是安全的。
// 子类一般很少重写该方法，因为框架总是会在依赖更改后调用 build 方法，
// 有些子类确实覆盖了这个方法，因为当它们的依赖关系发生变化时，它们需要做一些昂贵的工作（例如，网络获取），而且这些工作对于每次构建（build）来说都太昂贵了。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies called.');
  }
}

class Widget2 extends StatelessWidget {
  final int count;
  const Widget2({Key? key, this.count = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Widget2 is building...');
    // 这里不会刷新，因为 StatelessWidget 只构建一次，第一次构建时得到 count=0， 所以这里永远显示 0
    return Text('$count');
  }
}

// InheritedWidget 提供了一种数据在 widget 树中从上到下传递、共享的方式
// Flutter 中的 Widget 层次结构可以搞的非常深
// 如果在很深的一个地方需要用到父级的某个数据，并且希望父级数据发生更改时会通知所有依赖于该数据的所有子节点都自动更新，则使用 InheritedWidget 是个不错的选择。
// 访问数据是一种自下向上的查找操作，
// 主要通过 context.dependOnInheritedWidgetOfExactType 来向上查找最接近的候选者。
// 而什么适合需要更新又有依赖的子节点，是由 InheritedWidget#updateShouldNotify 来决定的
class SharingDataWidget extends InheritedWidget {
  // 该变量是 final 的，也就是说，外部不能对它进行更改，只能由它所在的父 Widget 重新构建???
  final int count;

  const SharingDataWidget({
    Key? key,
    this.count = 0,
    required Widget child,
  }) : super(key: key, child: child);

  // 定义一个便捷方法，方便子树中的 widget 获取这个包含共享数据的实例
  // 这里的 context 是子树传过来的，它代表子树中的某个节点，
  // 如果你深入了解 Flutter 中的 Element Tree，你就会清楚 BuildContext 实际上就是子节点对应的 Element 对象
  static SharingDataWidget? of(BuildContext context) {
    // 从子节点所在位置开始向上查找，直到找到最近的指定类型（这里是 SharingDataWidget）的节点，这里指定的类型必须是 InheritedWidget 的子类
    // 你可以在子树中
    return context.dependOnInheritedWidgetOfExactType<SharingDataWidget>();
  }

  // 该方法的返回值用来告诉 flutter 框架是否需要通知继承自该 InheritedWidget 的所有子节点
  @override
  bool updateShouldNotify(SharingDataWidget oldWidget) {
    debugPrint(
        '[SharingDataWidget#updateShouldNotify]: old count: ${oldWidget.count}, new count: $count, shouldNotify? ${oldWidget.count != count}');
    // 如果 count 发生了变化则返回 true，反之 false
    return oldWidget.count != count;
  }
}
