import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Home())));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alertDialog = AlertDialog(
      title: const Text('删除确认'),
      content: const Text('确定要删除吗?'),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('删除'),
        )
      ],
    );
    final cupertinoAlertDialog = CupertinoAlertDialog(
      title: const Text('删除确认'),
      content: const Text('确定要删除吗?'),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('删除'),
        )
      ],
    );
    final simpleDialog = SimpleDialog(
      title: const Text('我是可选的标题'),
      // backgroundColor: Colors.amber,
      // elevation: 140,
      // 控制对话框和屏幕边缘之间的边距
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
      // 控制对话框边框的形状，默认是一个长方形圆角边框，圆角半径为 4
      // shape: CircleBorder(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.topRight,
      // children 用来指定显示在标题下面的对话框显示的内容，该对话框内容显示在位于标题之下的 SingleChildScrollView 中，
      // 如果内容相当长，最终将对话框高度一直撑到其允许的最大高度后内容（由 insetPadding 控制，默认 EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0).）就需要滚动才能看到全部
      // 内容间距由 contentPadding 控制，默认为 const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
      children: const [
        Text('我是SimpleDialog 的内容'),
        Text(
            '我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，我是一段相当长的文本，'),
      ],
    );

    final simpleDialog2 = SimpleDialog(
      // 常用的是使用 SimpleDialogOption 列表，可以自定义指定任意的 Widget 列表
      children: [
        SimpleDialogOption(
          onPressed: () {},
          child: const Text('剪切'),
        ),
        SimpleDialogOption(
          onPressed: () {},
          child: const Text('复制'),
        ),
        SimpleDialogOption(
          onPressed: () {},
          child: const Text('粘贴'),
        ),
      ],
    );

    const myDialog = Padding(
      // 另外，这里默认是全屏显示的，内容会将背后的 Barrierer 遮罩层挡住，这样我们就不能通过点击背后的 Barrierer 关闭对话框了，此时我们需要将 Material 设定一个边距即可。
      padding: EdgeInsets.all(48.0),
      // 但如果只是一个 Text，显示出来的对话框内容会是黄色双下划线的红字，因为缺少材质包裹，这个需要我们自己处理，比如使用 Material 将 Text 包裹起来，
      child: Material(
        child: Text(
            'builder 一般返回 Dialog, 但也可以是其他任何类型 Widget，此处就只是一个普通文本，但是只写 Text 会显示带黄色双下划线的红字，你需要自己将其用 Material 材质包裹起来（比如 Material，Scaffold 等）'),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('showDialog(With AlertDialog)'),
              onPressed: () {
                // 显示一个模态对话框，没有 showModalDialog 这个方法，对话框默认就是模态的。但是有 showModalBottomSheet, showCupertinoModalPopup
                // 如果需要显示 IOS 风格的对话框，请使用 showCupertinoDialog
                showDialog(
                  context: context,
                  // builder 一般返回 Dialog, 但也可以是其他任何类型 Widget，比如 Text，但需要自己提供 Material 材质，且控制 Padding（以免内容全屏把背后的遮罩层给挡住）
                  builder: (_) => alertDialog,
                  // 注意：如果你仅仅只是希望对话框的样式是 IOS 风格的，就指定为 CupertinoAlertDialog, 但此时进入和退出动画、遮罩层的颜色和行为（点击不默认隐藏）会不一样，如果希望这些行为都和 IOS 风格，请使用 showCupertinoDialog
                  // builder: (_) => cupertinoAlertDialog,
                );
              },
            ),
            ElevatedButton(
              child: const Text('showDialog(With SimpleDialog1)'),
              onPressed: () {
                showDialog(context: context, builder: (_) => simpleDialog);
              },
            ),
            ElevatedButton(
              child: const Text('showDialog(With SimpleDialog2)'),
              onPressed: () {
                showDialog(context: context, builder: (_) => simpleDialog2);
              },
            ),
            ElevatedButton(
              child: const Text('showDialog(With any widget)'),
              onPressed: () {
                showDialog(context: context, builder: (_) => myDialog);
              },
            ),
            ElevatedButton(
              child: const Text('showCupertinoDialog(With AlertDialog)'),
              onPressed: () {
                // 显示 IOS 风格的对话框内容，和 showDialog 不同的是，进入和退出动画，模态遮罩层颜色，以及模态遮罩层行为（默认点击遮罩层不会关闭对话框）会不同。
                // 注意：跟 builder 返回的 Widget 没有关系，比如：showDialog 里也可以指定 CupertinoAlertDialog，显示出的对话框就是 IOS 风格的。
                showCupertinoDialog(
                  context: context,
                  // 不同于 showDialog 这里的默认值是 false
                  barrierDismissible: true,
                  // builder通常返回 CupertinoDialog 或者 CupertinoAlertDialog。
                  builder: (_) => cupertinoAlertDialog,
                );
              },
            ),
            ElevatedButton(
              child: const Text('showGeneralDialog'),
              onPressed: () {
                // 如果 showDialog 和 showCupertinoDialog 均不满足我们的需要（比如动画效果），请使用 showGeneralDialog，实际上前两者也是通过 showGeneralDialog 实现的
                showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: '',
                    // 动画时长
                    transitionDuration: const Duration(milliseconds: 400),
                    // 设置进入和退出动画，默认为淡入淡出，这里设置为放大缩小效果，且按指定的曲线运行
                    transitionBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return ScaleTransition(
                          scale: CurvedAnimation(
                            parent: animation,
                            curve: Curves.bounceInOut,
                          ),
                          child: child);
                    },
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return Center(
                        child: Container(
                          height: 300,
                          width: 250,
                          color: Colors.amber,
                          child: const Material(
                            child: Text(
                                '这里是对话框内容，可以是任意 Widget, 但是默认是没有材质包裹的，你需要确保内容父节点中有 Material 组件，比如使用 Material'),
                          ),
                        ),
                      );
                    });
              },
            ),
            ElevatedButton(
              child: const Text('showBottomSheet'),
              onPressed: () {
                // 在最近的 Scaffold 父组件上展示一个 Material 风格的 BottomSheet，位置同 Scaffold 组件的 bottomSheet，如果 Scaffold 设置了 bottomSheet，调用 showBottomSheet 会抛出异常。
                // 如果 context 往上查找找不到 Scaffold，会抛出异常：No Scaffold widget found.
                showBottomSheet(
                    context: context,
                    backgroundColor: Colors.amber,
                    elevation: 20,
                    shape: const CircleBorder(),
                    builder: (_) {
                      return Container(
                        height: 200,
                        color: Colors.red,
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
