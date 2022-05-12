import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  _buildItem(int index) {
    return Container(
      color: Colors.amberAccent,
      alignment: Alignment.center,
      child: Text('Item $index'),
    );
  }

  _buildGridViewByCount() {
    // 第一种常用构造函数，内部是用传入的参数构造了 gridDelegate，childrenDelegate：
    // gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    //   crossAxisCount: crossAxisCount,
    //   mainAxisSpacing: mainAxisSpacing,
    //   crossAxisSpacing: crossAxisSpacing,
    //   childAspectRatio: childAspectRatio,
    // ),
    // childrenDelegate = SliverChildListDelegate(
    //   children,
    //   addAutomaticKeepAlives: addAutomaticKeepAlives,
    //   addRepaintBoundaries: addRepaintBoundaries,
    //   addSemanticIndexes: addSemanticIndexes,
    // ),
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      // 宽高比
      childAspectRatio: 1.5,
      children: List.generate(10, (index) => _buildItem(index)),
    );
  }

  _buildGridViewByExtent() {
    // extent 和 count 构造函数不同的是：
    // 具体每行或每列排多少个，是根据屏幕尺寸和这里定义的 maxCrossAxisExtent（每个元素最大范围）自动计算的。
    // 最大跨轴长度，对于 scrollDirection 为 vertical，跨轴就是 x 轴
    // 其他参数基本相同（略）
    return GridView.extent(
      maxCrossAxisExtent: 100,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio: 1.5,
      children: List.generate(10, (index) => _buildItem(index)),
    );
  }

  _buildGridViewByBuilder() {
    // 使用 GridView.builder 构造函数相比于 count 很类似，差别在于：
    //  1. 它需要自己提供 gridDelegate 属性。
    //  2. 需要提供 itemCount 表示一共有多少元素，而 count 构造函数没有，具体多少个元素由自己通过的 chidlren 决定。而 builder
    //  3. builder 构造函数另外需要提供一个 itmerBuilder 属性，用于构造每一个元素
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return _buildItem(index);
      },
    );
  }

  _buildGridViewByCustom() {
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      childrenDelegate: SliverChildListDelegate(
        List.generate(10, (index) => _buildItem(index)),
      ),
    );
  }

  _buildGridViewByDefault() {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      children: List.generate(10, (index) => _buildItem(index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        // 使用不同构造函数构造 GridView
        // child: _buildGridViewByCount(),
        // child: _buildGridViewByExtent(),
        // child: _buildGridViewByBuilder(),
        // child: _buildGridViewByCustom(),
        child: _buildGridViewByDefault(),
      ),
    );
  }
}
