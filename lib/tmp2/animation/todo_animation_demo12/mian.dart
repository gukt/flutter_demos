import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// NOTE: 要添加 TickerProviderStateMixin
class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animController = AnimationController(
      duration: const Duration(seconds: 1),
      lowerBound: 100,
      upperBound: 300,
      vsync: this,
    );
    _printStatusAndValue();
    _animController.addListener(() {
      // forward...forward > completed
      _printStatusAndValue();
      // if (_animationController.status == AnimationStatus.completed) {
      //   // _animationController.reverse();
      //   // debugPrint(
      //   //     'Animation status: ${_animationController.status}, value: ${_animationController.value}');
      //   // _animationController.forward();
      //   // debugPrint(
      //   //     'Animation status: ${_animationController.status}, value: ${_animationController.value}');
      // }
      setState(() {});
    });
    _animation =
        CurvedAnimation(parent: _animController, curve: Curves.elasticInOut);
    _animation = Tween(begin: 100.0, end: 300.0).animate(_animation);

    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _printStatusAndValue() {
    debugPrint('${_animController.status}, value: ${_animController.value}');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building....');
    return Scaffold(
      body: Center(
        child: Container(
          width: _animController.value,
          height: _animController.value,
          color: Colors.amber,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animController.reset();
          _animController.forward();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
