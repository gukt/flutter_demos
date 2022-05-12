import 'package:flutter/material.dart';

///
/// See also:
/// - [文本框的创建和设定](https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a)
/// - [构建一个有验证判断的表单](https://flutter.cn/docs/cookbook/forms/validation)
/// - [文本框的创建和设定](https://flutter.cn/docs/cookbook/forms/text-input)
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 用于管理整个生命周期内的焦点（focus），在 initState 中实例化，在 dispose 中销毁
  late final FocusNode focusNode;
  // 用于控制文本框，获得当前值
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = TextEditingController()
      // 添加监听器，以监听文本框值的变化
      ..addListener(() {
        debugPrint('Value: ${controller.text}');
      });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Flutter 为我们提供了两个开箱即用的文本框： TextField 和 TextFormField
            // TextField 是最常用的文本输入组件。
            // TextFormField 内部封装了一个 TextField 并被集成在表单组件 Form 中。
            // 如果需要对文本输入进行验证或者需要与其他表单组件 FormField 交互联动，可以考虑使用 TextFormField。
            const TextField(
              // 如果想一旦文本框可见，就将其聚焦，就将 autofocus 设置为 true
              // 同一页面当前不能既有 autoFocus 为 true 的 TextField，又有别的 TextField 设置了 focusNode，这样会导致焦点在多个 TextField 中跳来跳去
              autofocus: false,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
            TextField(
              // 可以通过绑定 onChanged 处理程序监听输入框的值变更
              onChanged: (text) {
                debugPrint('Value changed: $text');
              },
            ),
            TextField(
              focusNode: focusNode,
              // 将 TextField 和 controller 绑定
              // 这样就可以使用 controller 随时获取文本框的值，而且还可以为 controller 添加监听器，以监听文本框值的变化
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          // 通过 controller 获取与之绑定的 TextField 的当前值
                          content: Text(controller.text),
                        );
                      });
                },
                child: const Text('获取文本值')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 点击这个按钮，让 focusNode 聚焦
          focusNode.requestFocus();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
