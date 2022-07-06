import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Scaffold(body: Home())));

class _Counter extends StatefulWidget {
  const _Counter({Key? key}) : super(key: key);

  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('_CounterState build');
    return Column(
      children: [
        Text('$count'),
        ElevatedButton(
          child: const Text('Button'),
          onPressed: () {
            count++;
            setState(() {});
            debugPrint('Button pressed');
          },
        )
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Home build');
    return Center(
      child: Container(
        color: Colors.amber,
        child: const _Counter(),
      ),
    );
  }
}
