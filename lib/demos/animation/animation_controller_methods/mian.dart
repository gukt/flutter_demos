import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// 当创建 AnimationController 时，需要传递一个vsync参数，防止屏幕外动画消耗不必要的资源。
// 单个 AnimationController 时，使用 SingleTickerProviderStateMixin；
// 多个 AnimationController 时，使用 TickerProviderStateMixin。
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      // 从 200 初始值开始
      value: 150,
      // 下边界值，如果控制器 value = lowerBound, 则它的状态就变为 dismissed，表示完成
      lowerBound: 100,
      // 上边界值
      upperBound: 300,
      // 表示动画执行的时长
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    // 添加当每次状态发生改变时调用的 listener
    _animationController.addStatusListener((status) {
      debugPrint('Status: $status');
      if (status == AnimationStatus.completed) {
        // 我们可以设置在动画完成时，调用 reset() 立即重置
        // reset 的内部逻辑其实就是将 value 设置为 lowerBound
        // 当然了，我们也可以直接通过 value 来设值，你也可以将值设置为小于 lowerBound, 或大于 upperBound，内部会做校验，不会产生越界错误，越界时取上下界的值。
        //
        // _animationController.value = 50;
        // _animationController.reset();
      }
    });
    // 添加当每次值发生改变时调用的 listener
    _animationController.addListener(() {
      // 每次值发生变化时确保 widget 可以更新
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _printStatusAndValue() {
    debugPrint(
        '${_animationController.status}, value: ${_animationController.value}');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building....');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _animationController.value,
              height: _animationController.value,
              color: Colors.amber,
            ),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  child: const Text('Forward'),
                  // 让动画正向前进
                  // 如果动画停留在 completed 状态，是调用 forward 会立即完成，因为动画已经不能再前进了
                  // 此时，可以通过 reset()、设置新的值（设置 value 属性）等途径让他回到之前的某个位置
                  // 如果想要向后运行动画，请调用 reverse() 方法
                  onPressed: _animationController.forward,
                ),
                ElevatedButton(
                  child: const Text('Reverse'),
                  onPressed: () {
                    // 先设定反方向运动时的动画时长（在构造函数中也可以指定）
                    _animationController.reverseDuration =
                        const Duration(seconds: 5);
                    // 朝 begining（lowerBound） 的方向运行，即反向运行
                    _animationController.reverse();
                  },
                ),
                ElevatedButton(
                  child: const Text('Stop'),
                  // 停止动画
                  onPressed: _animationController.stop,
                ),
                ElevatedButton(
                  child: const Text('fling'),
                  // 停止动画
                  onPressed: () {
                    _animationController.fling();
                    // _animationController.animateWith(simulation)
                  },
                ),
                ElevatedButton(
                  child: const Text('drive(TODO)'),
                  // 停止动画
                  onPressed: () {
                    // _animationController.drive(child)
                  },
                ),
                ElevatedButton(
                  child: const Text('animateWith(TODO)'),
                  // 停止动画
                  onPressed: () {
                    // _animationController.animateWith(simulation)
                  },
                ),
                ElevatedButton(
                  child: const Text('animateTo 250 (2s)'),
                  onPressed: () {
                    // 驱动动画从当前值到指定的目标值。
                    // animateTo() 还可以设定动画时长和 curve 曲线
                    // 和 animateBack 的唯一区别是，它 target 达到时，状态停留在 completed
                    _animationController
                        .animateTo(250, duration: const Duration(seconds: 2))
                        .then((_) {
                      debugPrint(
                          '[animateTo reached target] Status: ${_animationController.status}');
                    });
                  },
                ),
                ElevatedButton(
                  child: const Text('animateBack(200)'),
                  onPressed: () {
                    // 驱动动画从当前值到指定的目标值。
                    // 和 animateTo 的唯一区别是，它 target 达到时，状态停留在 dismissed
                    _animationController.animateBack(200).then((_) {
                      debugPrint(
                          '[animateBack reached target] Status: ${_animationController.status}');
                    });
                  },
                ),
                ElevatedButton(
                  child: const Text('Reset'),
                  // Reset to lower bound
                  // reset 或 设置是没有动画效果的，直接跳到指定的值
                  onPressed: _animationController.reset,
                ),
                ElevatedButton(
                  child: const Text('Repeat(reverse=false)'),
                  onPressed: () {
                    // 周期执行，如果 reverse 为 false，则一个周期执行完以后会立即跳到 min 值执行下一个循环，表现为达到最大值后方块突然变小再慢慢变大
                    // min 和 max 不能越界（lowerBound, upperBound），否则会报错
                    _animationController.repeat(
                      min: 150,
                      max: 250,
                      period: const Duration(seconds: 2),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Repeat(reverse=true)'),
                  onPressed: () {
                    // reverse = true, 先从小变大，再从大变小
                    _animationController.repeat(
                      min: 150,
                      max: 250,
                      reverse: true,
                      period: const Duration(seconds: 2),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Set value = 150'),
                  onPressed: () {
                    _animationController.value = 150;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
