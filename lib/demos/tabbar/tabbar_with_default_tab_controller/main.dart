import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 每个 AppBar 都需要指定一个 TabController, 我们可以自定义也可以使用系统提供的 DefaultTabController Widget，只需要将其作为 AppBar 的祖先节点即可
    // 使用 DefaultTabController 的好处还有可以不用声明为 StatefulWidget
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.keyboard_arrow_left),
          title: const Text('Welcom'),
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('精选')),
              Tab(child: Text('科学')),
              Tab(child: Text('社会')),
              Tab(child: Text('人文')),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Page1')),
            Center(child: Text('Page2')),
            Center(child: Text('Page3')),
            Center(child: Text('Page4')),
          ],
        ),
      ),
    );
  }
}
