import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late GravitySimulation simulation;

  @override
  void initState() {
    super.initState();

    // 定义一个重力模拟器，四个参数分别为：重力加速度，开始点，结束点，起始速度
    simulation = GravitySimulation(100.0, 0.0, 600.0, 1000.0);

    _animationController = AnimationController(
        lowerBound: 0,
        upperBound: 600,
        duration: const Duration(milliseconds: 500),
        vsync: this)
      ..addListener(() => setState(() {}));

    // animateWith 用来指定某个模拟器来驱动动画，
    // 此处指定上面定义的重力模拟器
    _animationController.animateWith(simulation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building....');
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: _animationController.forward,
                child: const Text('开始'),
              ),
              ElevatedButton(
                onPressed: _animationController.reset,
                child: const Text('重置'),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _animationController.forward(),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 100, top: _animationController.value),
              child: ClipOval(
                child: Container(width: 50, height: 50, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: EdgeInsets.only(top: _animationController.value),
      //         child: Container(width: 50, height: 50, color: Colors.redAccent),
      //       ),
      //       Container(
      //         width: _animationController.value,
      //         height: _animationController.value,
      //         color: Colors.amber,
      //       ),
      //       Wrap(
      //         spacing: 10,
      //         children: [
      //           ElevatedButton(
      //             child: const Text('Forward'),
      //             onPressed: _animationController.forward,
      //           ),
      //           ElevatedButton(
      //             child: const Text('Reset'),
      //             onPressed: _animationController.reset,
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
