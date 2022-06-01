import 'package:flutter/material.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // RelativeRect getPosition(BuildContext context) {
  //   final RenderBox button = context.findRenderObject()! as RenderBox;
  //   final RenderBox? overlay =
  //       Overlay.of(context)?.context.findRenderObject() as RenderBox;
  //   return RelativeRect.fromRect(
  //     Rect.fromPoints(
  //       button.localToGlobal(const Offset(0, 0), ancestor: overlay),
  //       button.localToGlobal(button.size.bottomRight(Offset.zero),
  //           ancestor: overlay),
  //     ),
  //     Offset.zero & overlay!.size,
  //   );
  // }

  Offset? getPosition(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox;
    return box?.localToGlobal(Offset.zero);
  }

  // toRelativeRect(Offset? offset)  {
  //   return RelativeRect.fromRect(rect, container)
  // }

  Size? getSize(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox;
    return box?.size;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey buttonKey = GlobalKey();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  key: buttonKey,
                  child: const Text('showMenu'),
                  onPressed: () {
                    showMenu(
                      context: context,
                      items: <PopupMenuEntry>[
                        const PopupMenuItem(child: Text('语文')),
                        const PopupMenuDivider(),
                        const CheckedPopupMenuItem(
                          child: Text('数学'),
                          checked: true,
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(child: Text('英语')),
                      ],
                      // 指定弹出位置，默认在屏幕左上角，如果需要在按钮下面弹出，需要计算一下位置
                      // 零时的
                      position: RelativeRect.fill,
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
