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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        // 使用默认构造函数比较麻烦一点，需要指定 gridDelegate 属性
        //
        // child: GridView(
        //   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //   //   crossAxisCount: 3,
        //   // ),
        // ),

        // // 第一种常用构造函数，内部是用传入的参数构造了 gridDelegate，childrenDelegate：
        // // gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        // //    crossAxisCount: crossAxisCount,
        // //    mainAxisSpacing: mainAxisSpacing,
        // //    crossAxisSpacing: crossAxisSpacing,
        // //    childAspectRatio: childAspectRatio,
        // //  ),
        // //  childrenDelegate = SliverChildListDelegate(
        // //    children,
        // //    addAutomaticKeepAlives: addAutomaticKeepAlives,
        // //    addRepaintBoundaries: addRepaintBoundaries,
        // //    addSemanticIndexes: addSemanticIndexes,
        // //  ),
        // child: GridView.count(
        //   crossAxisCount: 3,
        //   mainAxisSpacing: 1,
        //   crossAxisSpacing: 1,
        //   children: List.generate(10, (index) => _buildItem(index)),
        // ),
        child: GridView.extent(
          maxCrossAxisExtent: 4,
          children: List.generate(10, (index) => _buildItem(index)),
        ),
      ),
    );
  }
}
