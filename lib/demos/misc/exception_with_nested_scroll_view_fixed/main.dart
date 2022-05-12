import 'package:flutter/material.dart';

/// 使用 CustomScrollView 我们就可以将 Text, ListView, GridView 放到同一个 ScrollView 中
/// See also:
/// - https://medium.com/codechai/flutter-listview-gridview-inside-scrollview-68b722ae89d4
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(const [
              Text('Hello'),
              Text('Flutter'),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(color: Colors.red, height: 50),
              Container(color: Colors.orange, height: 50),
              Container(color: Colors.yellow, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.cyan, height: 50),
              Container(color: Colors.blue, height: 50),
              Container(color: Colors.purple, height: 50),
            ]),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildListDelegate(
              [
                Container(color: Colors.red),
                Container(color: Colors.orange),
                Container(color: Colors.yellow),
                Container(color: Colors.green),
                Container(color: Colors.cyan),
                Container(color: Colors.blue),
                Container(color: Colors.purple),
              ],
            ),
          )
        ],
      ),
    );
  }
}
