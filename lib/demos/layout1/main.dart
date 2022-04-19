import 'package:flutter/material.dart';

/// See also:
/// 1. https://flutter.cn/docs/development/ui/interactive
main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Column _buildButton(BuildContext context, String label, IconData icon) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(label, style: TextStyle(color: color)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout demo1')),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/lake.jpeg',
            width: 600.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
          // 示例中使用的是 Container 并指定 padding 属性
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                // 默认文本是居中对齐的
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: const Text(
                        'Oeschinen Lake Campground',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('Kandersteg, Switzerland',
                        style: TextStyle(color: Colors.grey[500])),
                  ],
                )),
                const Icon(Icons.star, color: Colors.red),
                const Text('41'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(context, 'CALL1', Icons.call),
              _buildButton(context, 'ROUTE', Icons.near_me),
              _buildButton(context, 'SHARE', Icons.share)
            ],
          ),
          // 文字块区域
          Container(
            padding: const EdgeInsets.all(32.0),
            child: const Text(
                '''Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
            '''),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.green[500]),
                Icon(Icons.star, color: Colors.green[500]),
                Icon(Icons.star, color: Colors.green[500]),
                const Icon(Icons.star, color: Colors.black),
                const Icon(Icons.star, color: Colors.black),
              ],
            ),
          )
        ],
      ),
    );
  }
}
