import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      // bottomSheet: Container(
      //   height: 100,
      //   color: Colors.amber,
      //   child: const Text('这是 BottomSheet 的内容，只是一个简单的文本'),
      // ),
      // bottomSheet: BottomSheet(
      //   animationController: BottomSheet.createAnimationController(this)
      //     ..forward(),
      //   builder: (BuildContext context) {
      //     return Container(
      //       height: 100,
      //       color: Colors.amber,
      //       child: const Text('这是定义在 Scaffold 上的 BottomSheet 的内容'),
      //     );
      //   },
      //   onClosing: () {},
      // ),
      body: Center(
        child: ElevatedButton(
          child: const Text('open bottom sheet'),
          onPressed: () {
            // 所谓 bottom sheet，是一个显示在 Scaffold 底部的一个任意类型的 Widget。不是必须要指定为 BottomSheet Widget。
            // BottomSheet 只是添加了滑动隐藏功能（注意：在 Scaffold.bottomSheet 属性上定义的 BottomSheet 是不会被隐藏的，它是持久显示的）。
            // 如果 Scaffold 上指定了 bottomSheet 后，再使用如 showBottomSheet 方法会报错(看代码里的 assert 很清楚，它不允许Scaffold 上之前已经指定了一个持久显示的 bottom sheet)
            // 如果 Scaffold 上没有定义 bottomSheet 属性，可以通过以下几种方法打开并显示一个:
            //  1. Scaffold.of(context).showBottomSheet(...)
            //  2. scaffoldKey.currentState?.showBottomSheet(...)
            //  3. showBottomSheet(...)，showModalBottomSheet 全局方法.
            // 以上三个方法有什么区别？ 答案是：没区别。
            // Scaffold.of(context) 和 scaffoldKey.currentState 都是获取得到一个 ScaffoldState 对象，而 showBottomSheet 是在 ScaffoldState 对象上定义的。全局方法 showBottomSheet 内部也是通过调用 Scaffold.of(context).showBottomSheet(...) 的。，showModalBottomSheet 只是多了一个遮罩层，可以设置点击遮罩层会自动关闭 bottom sheet.
            // 如果有 floatingActionButton, 则显示或隐藏 bottom sheet 时会对其位置有影响。
            // scaffoldKey.currentState?.showBottomSheet(
            // scaffoldKey.currentState?.showBottomSheet(
            // 注意：此例中，由于当前 context 上一级没有 Scaffold（Scaffold 在当前 build 里才构建的），所以不能直接调用全局的 showBottomSheet，会抛出：No Scaffold widget found.
            scaffoldKey.currentState?.showBottomSheet(
              (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.image),
                      title: const Text('图库'),
                      enableFeedback: true,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.camera_alt_outlined),
                      title: const Text('拍照'),
                      enableFeedback: true,
                    ),
                    ListTile(
                      title: TextButton(
                        onPressed: () {
                          // 除了默认的滑动关闭外，还可以使用 pop 关闭 bottom sheet
                          // or Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: const Text("取消"),
                      ),
                    )
                  ],
                ).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
