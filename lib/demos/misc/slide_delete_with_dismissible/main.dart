import 'package:flutter/material.dart';

/// 更使用的 package 请参考：flutter_slidable
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              // 每个 Dismissible 项都必须包含一个 Key，用来唯一鉴别 Widget
              key: Key(item),
              // 控制滑动方向，默认左右滑动
              // direction: DismissDirection.down,
              // 提供一个函数，让应用程序可以有机会确认是移除还是放弃
              confirmDismiss: (direction) async {
                // 弹出一个 AlertDialog，让用户确认后再删除
                // 这里要等待对话框的确认结果，所以加上 await
                return await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('删除确认'),
                        content: const Text('你确认要删除吗?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // 关闭对话框, 设置一个返回值 false，用于 showDialog 方法的返回值
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('取消'),
                          ),
                          TextButton(
                            onPressed: () {
                              // 从数据源中移除项目，并设置当前帧为 dirty
                              setState(() => items.removeAt(index));
                              // 成功移除后，显示一个 Snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$item 已删除')),
                              );
                              // 关闭对话框, 设置一个返回值 true，用于 showDialog 方法的返回值
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('删除'),
                          ),
                        ],
                      );
                    });
              },
              // 设置堆叠在 child 属性设置的 widget 背后的 Widget
              // 如果没有设置 secondaryBackground，则无论上下左右拖动，背景 Widget 都使用 background 设置的 Widget
              // 如果设置了 secondaryBackground，
              // 则 secondaryBackground 表示 child 被拖到左边或下面时显示的背景 Widget；此时 background 表示当 child 拖到右边或上面时显示的背景 Widget
              background: Container(color: Colors.green),
              secondaryBackground: Container(
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: InkWell(
                  onTap: () {
                    debugPrint('${items[index]} taped');
                  },
                  child: ListTile(title: Text(item))),
            );
          },
        ),
      ),
    );
  }
}
