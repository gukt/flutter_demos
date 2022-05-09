import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final rnd = Random();
    final x = rnd.nextDouble() * 2 - 1;
    final y = rnd.nextDouble() * 2 - 1;

    return Scaffold(
      body: AnimatedAlign(
        alignment: Alignment(x, y),
        duration: const Duration(seconds: 1),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        child: const Icon(Icons.add),
      ),
    );
  }
}
