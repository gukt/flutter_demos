import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Center(child: Text('Second page')),
      onPressed: () {
        // 导航到新路由
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Second()),
        );
      },
    );
  }
}

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Page2')));
  }
}
