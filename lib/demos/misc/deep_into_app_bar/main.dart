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
        // 有时候，我们的顶部 AppBar 加上显示一些图片（Flexible Space）和 TabBar 占用了很多屏幕高度，然后下面接一个可滚动的长列表，如果向下查看更多列表项时，顶部如果永远占用很多空间，体验会很不好，比较酷的方式是，顶部可以压缩以及展开
        // 幸运的是，Flutter 为我们提供了开箱即用的 SliverAppBar，它的效果很酷
        // 值得注意的是：如果要使用 SliverAppBar，就不是将其定义在 appBar 属性中，而是要将其放在 body 里，并用 CustomScrollView 将 SliverAppBar 和列表包裹起来
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: const Icon(Icons.keyboard_arrow_left),
              title: const Text('Welcome'),
              backgroundColor: Colors.green,
              bottom: const TabBar(
                tabs: [
                  Tab(child: Text('精选')),
                  Tab(child: Text('科学')),
                  Tab(child: Text('社会')),
                  Tab(child: Text('人文')),
                ],
              ),
              // 控制当用户向 AppBar 方向不断滚动时，AppBar 是否保持可见
              // 如果为 true，则向上方滚动到空间比较小时，会保持工具栏（顶部带 leading，title，trailing 的那行）及 bottom 指定的内容（本例是 TabBar）可见
              // 如果为 false，则整个 SliverAppBar 会随着不断向视图 start 位置处滚动出整个视图
              // 为 false 时，效果如下：
              //  1. flexibleSpace 高度逐渐被压缩并逐步淡出，同时 SliverAppBar 的 backgroundColor 指定的颜色淡入显示。
              //  2. 等 flexibleSpace 高度完全被收缩，此时只留下工具栏和其 bottom 指定的内容，此时背景颜色已完全显示
              //  3. 继续往上，工具栏和其 bottom 指定的内容会滚动出顶部视图以外从而不可见
              // 为 true 时，效果只和上面的第三步不同，此时工具栏和其 bottom 指定的内容会固定在视图 start 位置处不动
              pinned: true,
              // 是否只要向上滚动（即使是在 SliverList 上）时，SliverAppBar 就立即显示，向下滚动时仍然还是先滚动内容，直到内容到达顶部时才会拉伸 SliverAppBar
              // 注意：该值设为 true 且 pinned = true 时还会影响 AppBar 的显示行为，此时工具类和 bottom 都会显示，如果将 floating 设为 false，则只会显示 bottom
              floating: true,
              // 自动决定是展开还是收起状态，floating 为 true 生效, 默认 false
              // snap: true,
              // AppBar 是否应该拉伸以填充滚轴区域
              stretch: true,
              // 当向下移动便宜多少时才触发拉伸，默认值 100
              stretchTriggerOffset: 150,
              // 整个 SliverAppBar 完全展开是的高度
              expandedHeight: 200,
              // 介于顶部工具栏和底部 (bottom 属性指定的) TabBar 之间的灵活空间
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('松鼠'),
                titlePadding: const EdgeInsets.only(bottom: 50),
                background: Image.network(
                  'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 这里改使用 SliverList 来显示列表，而不是 ListView
            SliverList(
              // 使用 delegate 构建可在屏幕上滚动的列表条目
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text('Item #$index')),
                childCount: 1000,
              ),
            )
          ],
        ),
      ),
    );
  }
}
