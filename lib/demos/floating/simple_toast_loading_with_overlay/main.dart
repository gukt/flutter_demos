import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Toast.show(
                  context,
                  message: '🚀 你好，欢迎使用 flutter 👏🏻👏🏻👏🏻',
                  onDismiss: () {
                    debugPrint('Toast dismissed...');
                  },
                  duration: const Duration(seconds: 3),
                );

                // Toast.show(context,
                //     child: SizedBox(
                //       width: 300,
                //       child: ListTile(
                //         title: Text('🚀 你好，欢迎使用 flutter 👏🏻👏🏻👏🏻'),
                //         leading: Icon(Icons.snowboarding),
                //         trailing: IconButton(
                //           icon: const Icon(Icons.close),
                //           onPressed: () {
                //             debugPrint('Close this toast.');
                //           },
                //         ),
                //       ),
                //     ));

                // Toast.show(
                //   context,
                //   child: const CircularProgressIndicator(
                //     backgroundColor: Colors.white,
                //   ),
                // );
              },
              child: const Text('Open Loading...'),
            )
          ],
        ),
      ),
    );
  }
}

class Toast {
  static show(
    BuildContext context, {
    String message = 'message',
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double textSize = 14.0,
    TextStyle? textStyle,
    double radius = 4.0,
    double elevation = 40.0,
    EdgeInsets contentPadding = const EdgeInsets.all(16.0),
    VoidCallback? onDismiss,
    Widget? child,
  }) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (_) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.5,
        // 如果不使用 SafeArea，如果 top 为 0，显示时会覆盖系统状态栏
        child: SafeArea(
          child: Material(
            child: Container(
              padding: contentPadding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(radius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(15, elevation),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    )
                  ]),
              child: child ??
                  Text(
                    message,
                    style: textStyle ??
                        TextStyle(color: textColor, fontSize: textSize),
                  ),
            ),
          ),
        ),
      );
    });
    Overlay.of(context)?.insert(overlayEntry);
    Future.delayed(duration).then((value) {
      overlayEntry.remove();
      if (onDismiss != null) {
        onDismiss();
      }
    });
  }

  // static Future<void> hide() {
  //   toastOverlay?.remove();
  //   return Future.value(null);
  // }
}
