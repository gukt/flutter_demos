import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _large = true;

  @override
  Widget build(BuildContext context) {
    var rnd = Random();
    double size = rnd.nextInt(200).toDouble();
    double radius = rnd.nextInt(20).toDouble();
    Color color =
        Color.fromRGBO(rnd.nextInt(256), rnd.nextInt(256), rnd.nextInt(256), 1);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              onEnd: () {
                debugPrint('Anmation#1 finished.');
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  _large = !_large;
                });
              },
              child: AnimatedContainer(
                width: _large ? 200 : 100,
                height: _large ? 200 : 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(_large ? 20 : 10),
                ),
                duration: const Duration(seconds: 3),
                curve: Curves.elasticInOut,
                onEnd: () {
                  debugPrint('Anmation#2 finished.');
                },
                child: const Text('Click me!'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        child: const Icon(Icons.add),
      ),
    );
  }
}
