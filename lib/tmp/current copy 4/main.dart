import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: GridView.count(
          // 控制滚动方向，默认 vertical
          scrollDirection: Axis.vertical,
          //
          // controller:ScrollController(),
          //
          // 默认内容是可以滚动的，默认效果是 BouncingScrollPhysics
          // 如果你不想内容可以滚动，可以设置为 NeverScrollableScrollPhysics
          physics: const NeverScrollableScrollPhysics(),
          // 是否反向显示，默认为 false，
          // 以 scrollDirection 为 vertical 举例：
          // 默认从顶部开始显示第一个元素，如果 reverse 设为 true，则垂直方向上会反向显示
          reverse: true,
          // 如果是垂直滚动，则 y 是主轴，x 是跨轴
          crossAxisCount: 3,
          // 控制主轴和跨轴元素之间的间距，主轴跨轴随 scrollDirection 的方向变化而变化
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          // 控制内容内边距
          padding: const EdgeInsets.all(16.0),
          shrinkWrap: true,
          // addAutomaticKeepAlives
          // addRepaintBoundaries: ,
          // addSemanticIndexes: ,
          // cacheExtent:
          // semanticChildCount
          // dragStartBehavior
          // keyboardDismissBehavior
          // restorationId
          // clipBehavior:
          // 生成 10 个 Widgets
          children: List.generate(10, (index) {
            return Container(
              color: Colors.amber,
              alignment: Alignment.center,
              child: Text('Item $index'),
            );
          }),
        ),
      ),
    );
  }
}
