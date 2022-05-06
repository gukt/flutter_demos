import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // Future _openModalBottomSheet() async {
  //   final option = await showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 200.0,
  //           child: Column(
  //             children: <Widget>[
  //               ListTile(
  //                 title: const Text('拍照', textAlign: TextAlign.center),
  //                 onTap: () {
  //                   Navigator.pop(context, '拍照');
  //                 },
  //               ),
  //               ListTile(
  //                 title: const Text('从相册选择', textAlign: TextAlign.center),
  //                 onTap: () {
  //                   Navigator.pop(context, '从相册选择');
  //                 },
  //               ),
  //               ListTile(
  //                 title: const Text('取消', textAlign: TextAlign.center),
  //                 onTap: () {
  //                   Navigator.pop(context, '取消');
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });

  //   print(option);
  // }

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
            margin: const EdgeInsets.all(10.0),
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

  _buildBottomSheetBody() {
    return BottomAppBar(
      child: Container(
        height: 90.0,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: const <Widget>[
            Icon(Icons.pause_circle_outline),
            SizedBox(width: 16.0),
            Text('01:30 / 03:30'),
            Expanded(
              child: Text(
                '从头再来-刘欢',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showBottomSheeet2(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => _buildBottomSheetBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    showBottomSheeet1() {
      showBottomSheet(
        context: context,
        builder: (context) => _buildBottomSheetBody(),
      );
    }
    // final openBottomSheet1 = () {
    //   showBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return BottomAppBar(
    //           child: Container(
    //             height: 90.0,
    //             width: double.infinity,
    //             padding: const EdgeInsets.all(16.0),
    //             child: Row(
    //               children: const <Widget>[
    //                 Icon(Icons.pause_circle_outline),
    //                 SizedBox(width: 16.0),
    //                 Text('01:30 / 03:30'),
    //                 Expanded(
    //                   child: Text(
    //                     '从头再来-刘欢',
    //                     textAlign: TextAlign.right,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       });
    // };

    // _buildBottomSheet(BuildContext context) {
    //   return BottomAppBar(
    //     child: Container(
    //       height: 90.0,
    //       width: double.infinity,
    //       padding: const EdgeInsets.all(16.0),
    //       child: Row(
    //         children: const <Widget>[
    //           Icon(Icons.pause_circle_outline),
    //           SizedBox(width: 16.0),
    //           Text('01:30 / 03:30'),
    //           Expanded(
    //             child: Text(
    //               '从头再来-刘欢',
    //               textAlign: TextAlign.right,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => _openSnackbar1(context),
              child: const Text('Open SnackBar 1'),
            ),
            ElevatedButton(
              onPressed: () => _openSnackbar2(context),
              child: const Text('Open SnackBar 2'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return const Text('AAA');
                    });
              },
              child: const Text('Open BottomSheet 0'),
            ),
            ElevatedButton(
              onPressed: showBottomSheeet1,
              child: const Text('Open BottomSheet 1'),
            ),
            ElevatedButton(
              onPressed: () => showBottomSheeet2(context),
              child: const Text('Open BottomSheet 2'),
            ),
            ElevatedButton(
              onPressed: () => _openSnackbar2(context),
              child: const Text('Open SnackBar 2'),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        // TODO ??
        notchMargin: 10.0,
        shape: CircularNotchedRectangle(),
        // color: Colors.yellow,
        child: Row(
          // 设置大小
          mainAxisSize: MainAxisSize.max,
          // 对齐方式
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.share), onPressed: null),
            IconButton(icon: Icon(Icons.menu), onPressed: null),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'News'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Me'),
      //   ],
      // ),
    );
  }
}
