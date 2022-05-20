import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transform 用于在绘制之前对 child 的大小、形状、位置、朝向进行变换
      // Transform.scale
      body: Column(
        children: [
          // Transform.scale(
          //   scale: 2,
          //   // scaleX: 2,
          //   // scaleY: 2,
          //   // origin: const Offset(0, 0),
          //   // origin: const Offset(50, 50),
          //   // origin: const Offset(100, 100),
          //   child: Container(
          //     width: 100,
          //     height: 100,
          //     color: Colors.amber,
          //   ),
          // ),
          Transform.rotate(
            angle: 45 * 3.14 / 180,
            child: Container(width: 100, height: 100, color: Colors.amber),
          ),
        ],
      ),
    );
  }
}
