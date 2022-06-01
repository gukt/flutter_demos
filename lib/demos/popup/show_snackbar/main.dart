import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('显示 SnackBar'),
          onPressed: () {
            var messengerState = ScaffoldMessenger.of(context);
            // 清除队列中还没显示出来的 snackbar，以及让当前正在展现的 snackbar 运行一个 exit 动画让其退出
            messengerState.clearSnackBars();
            // 新的 snackbar 要通过 ScaffoldMessengerState 来调用了，老的方式是 ScaffoldState.showSnackBar
            ScaffoldMessenger.of(context)
                .showSnackBar(
                  SnackBar(
                    content: const Text('断网了?'),
                    // 设置背景颜色
                    backgroundColor: Colors.black,
                    // 控制 card 的阴影高度
                    elevation: 100,
                    // margin: const EdgeInsets.all(10.0),
                    behavior: SnackBarBehavior.floating,
                    // 控制snackbar 的边框形状
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    action: SnackBarAction(
                      label: '点击重试',
                      onPressed: () => debugPrint('Retrying...'),
                    ),
                  ),
                )
                // 当 snackbar 不再可见时表示完成，
                // 通过 closed 返回的 Future，可以添加完成时的回调
                .closed
                .then((reson) => debugPrint('Snackbar closed.'));
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Fav'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Me'),
        ],
      ),
    );
  }
}
