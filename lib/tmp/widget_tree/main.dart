import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _items = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    debugPrint('Building _HomeState, hashcode: $hashCode');

    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: ListView(
        children: _items.map((item) => ListItem(item)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _items.removeAt(0);
          });
        },
        child: const Icon(Icons.remove_circle_outline),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem(this.label, {Key? key}) : super(key: key);
  final String label;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  final _color = Color.fromRGBO(
    Random().nextInt(256),
    Random().nextInt(256),
    Random().nextInt(256),
    1,
  );

  late String _label;

  @override
  void initState() {
    super.initState();
    _label = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Building ListItem, color:$_color, label(from state):$_label, label(from widget):${widget.label}');
    return Container(
      color: _color,
      height: 50,
      // child: Text(widget.label),
      child: Text(_label),
    );
  }
}
