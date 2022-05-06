// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('底部自定义凸起导航栏示例')),
      body: Container(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
          NavItem(
            icon: const Icon(Icons.home),
            activeIcon: const Icon(Icons.home),
            label: 'Home',
          ),
          NavItem(
            icon: const Icon(Icons.newspaper),
            activeIcon: const Icon(Icons.newspaper),
            label: 'News',
          ),
          NavItem(
            icon: const Icon(Icons.favorite),
            activeIcon: const Icon(Icons.favorite),
            label: 'Favorite',
          ),
          NavItem(
            icon: const Icon(Icons.account_circle_sharp),
            activeIcon: const Icon(Icons.account_circle_sharp),
            label: 'Me',
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'News'),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Me'),
      //   ],
      // ),
    );
  }
}

/// 自定义的底部导航栏
///
/// selectedIconColor
/// 图标大小是固定的，文字可以指定选中和不选中
///
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    this.onTap,
    this.currentIndex = 0,
    required this.items,
  }) : super(key: key);

  final List<NavItem> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: widget.items.map((item) {
          var widgets = [];

          return SizedBox(
            height: 59,
            child: Column(children: [
              item.icon,
              Text(item.label!),
            ]),
          );
        }).toList(),
      ),
    );
  }
}

class NavItem {
  NavItem({
    required this.icon,
    required this.activeIcon,
    this.label,
  });

  final Widget icon;
  final Widget activeIcon;
  final String? label;
}

// class NavItem {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 49,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8.0),
//         child: Column(
//           // 一定要设置为 min，不然 Column 将撑满屏幕
//           // mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.home),
//             Text('Home'),
//           ],
//         ),
//       ),
//     );
//   }
// }
