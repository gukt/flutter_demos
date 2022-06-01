import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      lowerBound: 100,
      upperBound: 300,
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animationController.addListener(() {
      debugPrint('value:${animationController.value}');
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('_HomeState is building...');
    return Scaffold(
      body: Center(
        child: Container(
          width: animationController.value,
          height: animationController.value,
          color: Colors.amber,
        ),
      ),
    );
  }
}
