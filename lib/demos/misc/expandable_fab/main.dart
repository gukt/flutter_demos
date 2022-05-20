import 'package:flutter/material.dart';
import 'dart:math' as math;

/// [创建一个点击展开的 FAB](https://flutter.cn/docs/cookbook/effects/expandable-fab)
void main() {
  runApp(
    const MaterialApp(
      home: ExampleExpandableFab(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ExampleExpandableFab extends StatelessWidget {
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  const ExampleExpandableFab({Key? key}) : super(key: key);

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expandable Fab'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: 25,
        itemBuilder: (context, index) {
          return FakeItem(isBig: index.isOdd);
        },
      ),
      // ExpandableFab 覆盖几乎所有屏幕尺寸，只是右边和底部留有一定的距离
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        // 指定三个展开后可看见的按钮
        children: [
          ActionButton(
            onPressed: () => _showAction(context, 0),
            icon: const Icon(Icons.format_size),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 1),
            icon: const Icon(Icons.insert_photo),
          ),
          ActionButton(
            onPressed: () => _showAction(context, 2),
            icon: const Icon(Icons.videocam),
          ),
        ],
      ),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  // 展开状态时，按钮离右下角的最大距离
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // expand 用于创建一个父级允许的尽可能大的盒子
    return SizedBox.expand(
      // 这个 stack 是很大的，左上角是屏幕原点，有下角和右边及底部有一点点的距离
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        // 指定这个 Stack 里所有包含的 children
        // 本例中，当展开时，原先的按钮会变成透明的，x 这个按钮会显示
        // 而不是通过在同一个按钮上切换显示图标，大小，背景来实现的
        children: [
          // 右下角，展开状态时显示的按钮
          _buildTapToCloseFab(),
          // 展开状态显示的按钮
          ..._buildExpandingActionButtons(),
          // 右下角，收缩状态时显示的按钮
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    // 相邻节点之间间隔的角度，总角度是 90 度
    // 也就是说，如果有三个按钮，则每个按钮间隔角度是 45 度
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      // 控制展开/收缩按钮动画，动画效果是：
      // 展开时：按钮变小，背景变成白色，按钮图标切换，透明度变换
      child: AnimatedContainer(
        // 控制变形时的对齐方式，这里指定为中心点变换，默认为左上角
        transformAlignment: Alignment.center,
        // 指定变换矩阵
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  // 角度表示的方向
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder 继承自 AnimatedWidget,
    // 而 AnimatedWidget 是一层简易的封装，将 animation 添加监听器，调用 setState(), 移除监听器等常规操作封装了起来而已，具体见他的代码实现，比较简单。
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        // fromDirection 是根据传入的方向和距离来计算 offset
        // 第一个参数是方向，注意是弧度值，角度需要转换为弧度，具体公式为：
        // 角度值 * π / 180（因为圆的一周 360 度对应弧度是 2π）
        // 第二个参数是距离，根据 animation 的不断变化，这个距离会不断变化
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          // 控制图片的显示和隐藏过程伴随着旋转效果，angle 参数也是弧度值
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      // 将整个 child 包裹在 FadeTransition 实现淡入淡出效果
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Material 表示一小块材质
    return Material(
      // 定义材质的形状，此处指定一个圆形边框
      shape: const CircleBorder(),
      // 阴影高度
      elevation: 4.0,
      // 裁剪行为，此处指定为使用抗锯齿裁剪
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: Colors.white,
        // color: theme.colorScheme.secondary,
      ),
    );
  }
}

class FakeItem extends StatelessWidget {
  const FakeItem({
    Key? key,
    required this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
