import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.keyboard_arrow_left),
        title: const Text('Welcom'),
        // 可以将 TabBar 设置到 title 中，但这里我们设置到 bottom 中
        // bottom 是在 AppBar 下面显示的 Widget，必须是一个 PreferredSizeWidget
        //
        bottom: TabBar(
          // 指定我们自定义的 TabController
          controller: _tabController,
          // 点击 TabBar 选项时的回调，即使 index 没有改变，它也会被触发。
          // 它适合那些在点击标签时需要做一些额外工作的场景。
          // 注意，通过滑动 TabView 来切换 Tab 项是不会触发这个回调的，因为这个回调只适用于 TabBar 选项被点击才触发。
          onTap: (index) {
            debugPrint('tab$index taped.');
          },
          // 控制当一行显示不下时，是不是可以滚动
          // 默认 false，当 false 时，对齐方式为 spaceAround, 反之居中显示
          // 你可以调整一下看看显示效果会有什么变化
          isScrollable: true,
          enableFeedback: false,
          // 底部指示器的高度，默认 2
          // indicatorWeight: 2,
          // 内边距，默认为 0
          // padding: const EdgeInsets.all(16),
          // indicator 表示选中状态时的指示器，默认是一条下划线
          // 下面这样设置，indicator 是一个高亮块，选中的项会整体被高亮
          indicator: const BoxDecoration(
            color: Colors.black12,
            border: Border(bottom: BorderSide(color: Colors.white, width: 3)),
          ),
          // Padding for indicator
          // indicatorPadding: const EdgeInsets.all(2.0),
          // 定义如何计算所选选项卡指示符的大小，默认按 tab 宽度算，如果按文本算，则会变窄
          // 你可以设置为 TabBarIndicatorSize.label 试试
          // indicatorSize: TabBarIndicatorSize.label,
          // 定义墨水响应焦点、悬停和飞溅颜色。
          overlayColor: MaterialStateProperty.all(Colors.green),
          // 设置 ScrollPhysics, 此处使用的 NeverScrollableScrollPhysics 表示不允许用户在 tabs 上滚动，但是用户点击靠后的选项，TabBar 会自动帮我们滚动后面的选项卡
          // 如果不设 physics，我们就可以随意滚动 TabBar
          physics: const NeverScrollableScrollPhysics(),
          // physics: const BouncingScrollPhysics(),
          // physics: const ClampingScrollPhysics(),
          // physics: const AlwaysScrollableScrollPhysics(),
          // 指定 tabbar 的 tabs 列表，
          tabs: const [
            // Tab 还可以指定 icon
            Tab(child: Text('精选')),
            Tab(child: Text('科学与技术')),
            Tab(child: Text('社会')),
            Tab(child: Text('人文')),
            Tab(child: Text('人工智能')),
            // 可以是任意 Widget
            Text('其他')
          ],
        ),
        // centerTitle: false,
      ),
      body: TabBarView(
        // TabBar 要和这里的 TabBarView 共用同一个 TabController
        controller: _tabController,
        children: const [
          Center(child: Text('Page1')),
          Center(child: Text('Page2')),
          Center(child: Text('Page3')),
          Center(child: Text('Page4')),
          Center(child: Text('Page5')),
          Center(child: Text('Page6')),
        ],
      ),
    );
  }
}
