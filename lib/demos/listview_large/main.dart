import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 示例：使用 ListView.builder 实现一个可以无限滚动的单词列表。
///
/// * 如果 main 函数里什么都不写，启动后就是一个空的黑乎乎的页面
/// * 需要添加依赖：`flutter pub add english_words`
/// * 如何限制屏幕方向
/// * 构建一个无限滚动的单词列表，该程序会不断生成 10 组单词
///
/// see also:
/// 1. http://www.ptbird.cn/Flutter-listview-builder-listview-separated.html
void main() {
  // 如果 App 设计仅能工作在竖向屏幕，你可以限制一下屏幕方向为从上到下
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 不要使用 print 方法，而是使用 debugPrint
  debugPrint('App is starting.');

  // 设计界面先从定义一个 Widget 开始，然后在 main 函数里使用 runApp 来启动它
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to flutter'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  // 继承自 StatefulWidget 的子类都要实现 createState() 方法
  @override
  createState() => _RandomWordsState();
}

// 创建一个自定义的 State 类
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};

  Widget _buildSuggestions() {
    // ListView 提供了 ListView.builder 这个命名构造函数，它适用于构建长列表，
    // 优点是：按需构建，有回收机制，性能好。
    //
    // 通过 ListView(...) 直接构造列表的优点是：简单。适用于短列表。
    // 缺点是：没有回收机制，当列表项过多时，该构造函数会创建所有列表项，可能导致内存问题。
    //
    // ListView.builder 需要提供 itemBuilder 回调函数，它接受两个参数：
    // * itemCount（可选） - 列表项个数，建议提供，该参数可供 ListView 预估最大滚动范围。
    // * context - BuildContext 实例
    //
    // 如果你想用分隔符将列表项分开，可使用 ListView.seperated 构造函数
    // 它和 ListView.builder 唯一的不同是多了一个 separatorBuilder 回调参数，
    // 该回调函数始终返回一个 Widget，这个 Widget 就是列表项目之间的分隔。
    //一般返回 Divider，但不是必须的， 你可以返回任何的 Widget 作为分隔。
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        // 每次当 index 发生变化时，该 itemBuilder 会反复调用
        debugPrint('i = $index');
        // 在每一列之前，添加一个分隔线
        if (index.isOdd) return const Divider();
        // 语法 "i ~/ 2" 表示 i 除以 2，但返回值是整形（向下取整, floor divide），
        // 比如 i 为：1, 2, 3, 4, 5 时，结果为0, 1, 1, 2, 2
        // 这可以计算出 ListView 中减去分隔线后的实际单词对数量
        final idx = index ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (idx >= _suggestions.length) {
          // 接着再生成 10 个单词对，然后添加到建议列表
          debugPrint('Generating 10 rows');
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[idx]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
