import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: ListView(
              // 如果想在 Column 中使用 ListView 则需要指定 shrinkWrap 为 true
              // 不然会抛出如下异常：
              // The following assertion was thrown during performResize():
              // Vertical viewport was given unbounded height.
              shrinkWrap: true,
              // yyju
              children: List.generate(
                800,
                (index) => ListTile(
                  title: Text(
                    '🐒🐘🐷🐊🐶🦘🐅🦎🐈#$index',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              )),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            "Elevated Button",
          ),
        ),
      ]),
    );
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              ListTile(title: Text('xxx')),
              ListTile(title: Text('xxx')),
              ListTile(title: Text('xxx')),
              ListTile(title: Text('xxx')),
            ],
          ),
          Positioned(
            bottom: 0,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(30.0),
                ),
              ),
              child: const Text('进入首页'),
            ),
          ),
        ],
      ),
    );
  }
}
