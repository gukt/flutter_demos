import 'package:flutter/material.dart';

/// See also:
/// - https://flutter.cn/docs/cookbook/lists/floating-app-bar
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.keyboard_arrow_left),
          title: const Text('Welcome'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('精选')),
              Tab(child: Text('科学')),
              Tab(child: Text('社会')),
              Tab(child: Text('人文')),
            ],
          ),
          // 该小部件位于 AppBar 和 TabBar 的后面。它的高度将与应用程序栏的整体高度相同。
          // 虽然这叫 flexibleSpace，但其实它的空间实际上不是灵活的，除非 AppBar 的容器改变了 AppBar 的大小。
          // 该属性通常设置为 FlexibleSpaceBar
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('松鼠'),
            background: Image.network(
              'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
