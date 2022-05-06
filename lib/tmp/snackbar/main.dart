import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

// 打开默认样式的
  _openSnackbar1(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('断网了?'),
        padding: EdgeInsets.all(32.0),
        duration: Duration(minutes: 30),
        // action: SnackBarAction(
        //   label: '点击重试',
        //   onPressed: () {
        //     // 执行按钮逻辑
        //     debugPrint('Retrying...');
        //   },
        // ),
      ),
    );
  }

  _openSnackbar11(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('断网了?'),
        // action: SnackBarAction(
        //   label: '点击重试',
        //   onPressed: () {
        //     // 执行按钮逻辑
        //     debugPrint('Retrying...');
        //   },
        // ),
      ),
    );
  }

  _openSnackbar2(BuildContext context) {
    var messengerState = ScaffoldMessenger.of(context);
    messengerState.clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: const Text('断网了?'),
            // backgroundColor: Colors.blueGrey,
            elevation: 100,
            // margin: const EdgeInsets.all(10.0),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            action: SnackBarAction(
              label: '点击重试',
              onPressed: () {
                // 执行按钮逻辑
                // debugPrint('Retrying...');
              },
            ),
          ),
        )
        .closed
        .then((reson) {
      debugPrint('Snackbar closed.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      SnackBar(
                        content: const Text('网络有中断?'),
                        duration: Duration(seconds: 1),
                        padding: EdgeInsets.all(20),
                        // margin: EdgeInsets.all(32.0),
                        action: SnackBarAction(
                            label: '点击重试',
                            onPressed: () => debugPrint('Do something')),
                      ),
                    )
                    .closed
                    .then((value) {
                  debugPrint('Closed!');
                });
              },
              child: const Text('Snackbar1'),
            ),
            ElevatedButton(
              onPressed: () => _openSnackbar1(context),
              child: const Text('Snackbar1'),
            ),
            ElevatedButton(
              onPressed: () => _openSnackbar2(context),
              child: const Text('Snackbar2'),
            ),
          ],
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
