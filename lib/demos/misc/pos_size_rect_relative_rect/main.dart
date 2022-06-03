import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  /// 这个是从其他文章中抄来的，和 [getRelativeRect] 比起来，显然这个写的比较累赘，不易读，
  ///
  /// **NOTE：不建议使用**
  RelativeRect getRelativeRect2(BuildContext context) {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox? overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;
    return RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(const Offset(0, 0), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay!.size,
    );
  }

  RelativeRect getRelativeRect(BuildContext context) {
    Offset? position = getPositionToGlobal(context);
    if (position == null) {
      return RelativeRect.fill;
    }
    Size? size = getSize(context);
    return RelativeRect.fromSize(
      // 位置和尺寸就可以确定一个 Rect，运算符 & 就是做的这个事
      position & size!,
      MediaQuery.of(context).size,
    );
  }

  Offset? getPositionToGlobal(BuildContext context) {
    // context 一定要对应你期望获取位置的那个 Widget 的 Element，
    // 这里要非常注意，经常会将上层父节点对应的 context 传入，请仔细查看本例中几个按钮中的逻辑
    final RenderBox? box = context.findRenderObject() as RenderBox;
    // Convert the given point from the local coordinate system for this box to the global coordinate system in logical pixels.
    // 将 box 在本地坐标系统中对应的值，转换为全局坐标系中对应的值
    return box?.localToGlobal(Offset.zero);
  }

  Size? getSize(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox;
    return box?.size;
  }

  // RelativeRect getMenuPosition(BuildContext context) {
  //   RelativeRect relativeRect = getRelativeRect(context);
  // }

  @override
  Widget build(BuildContext context) {
    debugPrint('MediaQuery Size: ${MediaQuery.of(context).size}');
    GlobalKey _buttonKey = GlobalKey();
    GlobalKey _showMenuButtonKey = GlobalKey();
    var posAndSizeInfo1 = '点击显示位置和尺寸';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      // 获得 context 指向的 Element 的渲染框的位置，
                      // 注意: 一定要注意 context 到底和那个 Widget 的 Element 相对应，新手很容易弄错。
                      var pos = getPositionToGlobal(context)!;
                      // 获得 context 指向的 Element 的渲染框的尺寸
                      var size = getSize(context)!;
                      // 因为 pos 是相对于整个屏幕的，所以 rectToGlobal 的 LTRB 值也是相对于屏幕坐标系的
                      // Rect 表示一个二维不可变矩形，它定义了矩形的四个点，这样矩形的尺寸即可确定， 四个点的值因坐标参照系的不同而不同。
                      var rectToGlobal = Rect.fromLTWH(
                        pos.dx,
                        pos.dy,
                        size.width,
                        size.height,
                      );
                      // 所谓'相对矩形'（RelativeRect）它只定义这个矩形距离参考容器四条边的距离，这和 Stack 中的 Positioned 概念很类似，因此，它的参考容器变化时，该 RelativeRect 表示的矩形大小是变化的。
                      var relativeRectToGlobal = getRelativeRect(context);
                      posAndSizeInfo1 =
                          'pos: $pos, size: $size, rectToGlobal: $rectToGlobal, relativeRectToGlobal: $relativeRectToGlobal';
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 300,
                        height: 100,
                        color: Colors.amber,
                        child: Text(posAndSizeInfo1),
                      ),
                    ],
                  ),
                );
              },
            ),
            CustomButton(
              text: const Text('打印按钮大小和位置（different context）'),
              onTap: (ctx) {
                // context 是 Home Widget 对应的 Element，
                // 打印信息如下：
                // flutter: Position: Offset(0.0, 0.0)
                // flutter: Size: Size(375.0, 667.0)
                debugPrint('Position: ${getPositionToGlobal(context)}');
                debugPrint('Size: ${getSize(context)}');

                // ctx 对应的是 CustomButton Widget 对应的 Element
                // 所以下两行可以准确获得 CustomeButton 的位置和大小
                // 打印信息如下：
                // flutter: Position: Offset(155.5, 333.5)
                // flutter: Size: Size(64.0, 48.0)
                debugPrint('Position: ${getPositionToGlobal(ctx)}');
                debugPrint('Size: ${getSize(ctx)}');
              },
            ),
            CustomButton(
              text: const Text('构造 Rect 实例'),
              onTap: (ctx) {
                var size = getSize(ctx);
                var origin = Offset.zero;
                // Rect 表示一个二维的，不可变的矩形，该矩形的坐标是相对于给定的原点的。
                // 比如：如果将 Rect 的 origin 设置为 Offset.zero 即表示相对于屏幕左上角，原点是用来确定长方形的左上角位置的。
                // 你可以通过几个构造函数构造 Rect, 如下面的示例：Rect.fromLTWH、Rect.fromLTRB、Rect.fromCenter、Rect.fromPoints 构成的都是等效的。
                var rect1 = Rect.fromLTWH(
                  size!.topLeft(origin).dx,
                  size.topLeft(origin).dy,
                  size.width,
                  size.height,
                );

                var rect2 = Rect.fromLTRB(
                  size.topLeft(origin).dx,
                  size.topLeft(origin).dy,
                  size.bottomRight(origin).dx,
                  size.bottomRight(origin).dy,
                );

                var rect3 = Rect.fromCenter(
                  center: size.center(origin),
                  width: size.width,
                  height: size.height,
                );

                var rect4 = Rect.fromPoints(
                  size.topLeft(origin),
                  size.bottomRight(origin),
                );

                // 除了通过Rect 的命名构造函数构造 Rect，还可通过左上角的位置（offset）以及尺寸（size）来构造，具体通过 & 运算符来创建，& 操作内部是调用 Rect.fromLTWH 的
                var rect5 = origin & size;

                // button size: 181 * 48
                // button global positon: Offset(97.0, 309.5) 相对于屏幕左上角
                // flutter: rect1: Rect.fromLTRB(0.0, 0.0, 181.0, 48.0)
                debugPrint('rect1: $rect1');
                debugPrint('rect2: $rect2');
                debugPrint('rect3: $rect3');
                debugPrint('rect4: $rect4');
                debugPrint('rect5: $rect5');
              },
            ),
            CustomButton(
              text: const Text('Rect&RelativeRect'),
              onTap: (ctx) {
                var position = getPositionToGlobal(ctx);
                var size = getSize(ctx);
                var rect = position! & size!;
                var overlaySize = getSize(Overlay.of(ctx)!.context);
                var relativeRect1 = RelativeRect.fromRect(
                  position & size,
                  Offset.zero & overlaySize!,
                );
                debugPrint(
                    'position: $position, \nsize: $size, \nrect: $rect, \nrelativeRect1: $relativeRect1, \nrelativeRect2: ${getRelativeRect2(ctx)}, \nrelativeRect3: ${getRelativeRect(ctx)}');
                debugPrint(
                    'toRect: ${relativeRect1.toRect(Offset.zero & MediaQuery.of(ctx).size)}');
                debugPrint(
                    'toSize: ${relativeRect1.toSize(MediaQuery.of(ctx).size)}');

                var screenSize = MediaQuery.of(ctx).size;
                var rect1 = const Rect.fromLTRB(100, 100, 200, 200);
                var relativeRect11 = RelativeRect.fromSize(rect1, screenSize);
                debugPrint('rect1: $rect1, relativeRect11: $relativeRect11');
              },
            ),
            ElevatedButton(
              key: _showMenuButtonKey,
              child: const Text('弹出菜单（需要提供 RelativeRect）'),
              onPressed: () {
                showMenu(
                  context: context,
                  items: <PopupMenuEntry>[
                    const CheckedPopupMenuItem(child: Text('元')),
                    const PopupMenuDivider(),
                    const PopupMenuItem(child: Text('万元')),
                  ],
                  // 指定弹出位置，默认在屏幕左上角，如果需要在按钮下面弹出，需要计算一下位置
                  position:
                      getRelativeRect(_showMenuButtonKey.currentContext!).shift(
                    Offset(
                        0,
                        getSize(_showMenuButtonKey.currentContext!)!.height +
                            4),
                  ),
                );
              },
            ),
            SizedBox(
              child: Builder(
                // 如果不想像上面那样为按钮创建一个单独的 Widget，也可以用 Builder 将其包裹起来，并且使用 builder 的 BuildContext 参数来获取位置和大小
                // 注意：此例因为 Builder 是放在 Column 中的，必须为其设置大小，不然会报错，所以将其放到 SizedBox 中，这样就可解决问题。
                builder: (BuildContext ctx) {
                  return ElevatedButton(
                    child: const Text('打印按钮大小和位置（使用 Builder 得到 context）'),
                    onPressed: () {
                      debugPrint('Position: ${getPositionToGlobal(ctx)}');
                      debugPrint('Size: ${getPositionToGlobal(ctx)}');
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              key: _buttonKey,
              child: const Text('打印按钮大小和位置（使用 key)'),
              onPressed: () {
                var context = _buttonKey.currentContext!;
                debugPrint('Position: ${getPositionToGlobal(context)}');
                debugPrint('Size: ${getPositionToGlobal(context)}');
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onTap, this.text}) : super(key: key);
  final Widget? text;
  final void Function(BuildContext context)? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: text,
      onPressed: () {
        onTap?.run(context);
      },
    );
  }
}
