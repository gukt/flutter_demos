import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 关于 Material Design Dialog 请见官方文档：https://m3.material-io.cn/components/dialogs/overview
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('确认退出吗?'),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('确定'),
                    ),
                    TextButton(
                      onPressed: () {
                        // 使用 Navigator.pop() 关闭对话框
                        Navigator.of(context).pop();
                      },
                      child: const Text('取消'),
                    )
                  ],
                );
              },
            );
          },
          child: const Text('打开确认退出对话框'),
        ),
      ),
    );
  }
}
