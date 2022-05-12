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
        color: Colors.pink,
        child: GridView.count(
          // 控制滚动方向，默认垂直滚动
          // scrollDirection: Axis.horizontal,
          //
          // controller:ScrollController(),
          //
          // physics: ScrollPhysics(),
          // reverse
          // primary
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
