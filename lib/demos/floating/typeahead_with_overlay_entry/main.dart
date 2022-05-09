import 'package:flutter/material.dart';

/// 本实例演示了使用 OverlayEntry 实现文本输入框的提示，并可以跟随滚动。
///
/// 本例是对[该篇文章](https://medium.com/saugo360/https-medium-com-saugo360-flutter-using-overlay-to-display-floating-widgets-2e6d0e8decb9)所述内容的实现及相关注释
///
/// 该作者还写了个很受欢迎的组件：[flutter-typeahead](https://pub.dev/packages/flutter_typeahead#flutter-typeahead)
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              const CountriesField(),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address1'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address2'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address3'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address4'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address5'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address6'),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  // submit the form
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CountriesField extends StatefulWidget {
  const CountriesField({Key? key}) : super(key: key);

  @override
  _CountriesFieldState createState() => _CountriesFieldState();
}

class _CountriesFieldState extends State<CountriesField> {
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      // 当获得焦点时显示浮动层；反之移除浮动层
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    // 找到当前 CountriesField Widget 对应的 RenderObject（实际上是 RenderBox 对象）
    // 找到此 RenderBox 对象后，我们就可以得知该 Widget 的位置，大小以及其他一些信息
    // 这些信息在后面可以帮助我们决定如何显示浮动提示层
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    // 通过 localToGlobal 可以得到 RenderBox 相对于屏幕的 offset
    // 以下代码目的是将 RenderBox 的（0,0）点转换为相对于屏幕的坐标
    var offset = renderBox.localToGlobal(Offset.zero);

    // 创建一个 OverlayEntry 对象并返回
    // OverlayEntry 对象是用来显示的浮动层，它会被插入到 Overlay 的 stack 中
    return OverlayEntry(
      // OverlayEntry 本身就是放在 Stack 中的，所以这里可以直接用 Positioned
      // 永远记住 Positioned Widget 必须要放在 Stack 中
      // 也永远记住，Overlay 本身是内置 Stack 的
      builder: (context) => Positioned(
        // 使用上面获取到的 TextField 的 RenderBox 相对于屏幕的 offset 信息，
        // 设定 OverlayEntry 的相对位置
        left: offset.dx,
        // offset 是使用的 TextField 左上角的原点换算的相对于屏幕的坐标，
        // 因此垂直位置上我们要加上 size.height，并且多加 5 个像素，留点空白位置
        top: offset.dy + size.height + 5.0,
        // 宽度和文本框等同
        width: size.width,
        // 这里要重点介绍一下 CompositedTransformFollower 是干什么的
        // 如果我们表单页面可以滚动，当滚动时弹出层由于是固定的就会因滚动而分离
        // 我们期望的结果是弹出提示层始终跟随输入框一起滚动
        // Flutter 为我们提供了两个 Widget 帮我们实现这一滚动跟随的需求场景，它们是：
        // CompositedTransformFollower 和 CompositedTransformTarget，
        // 它们两之间通过 连接 进行连接，
        // 此例中，弹出层的内容 Widget 是 follower，跟随的目标是输入框（见 build() 内部的 CompositedTransformTarget）
        child: CompositedTransformFollower(
          link: _layerLink,
          // 设定当目标不能被 link 时（（超出屏幕外不可见）），是仍然显示 follower 还是隐藏它，一般设置为隐藏，这样体验上感觉很好
          // 如果设置为 true，你会发现输入框滚出屏幕不可见时，follower 会跳到最初没滚动之前所在的显示位置
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          // 创建一片材质，将内容包裹其中，在此使用它原因有 2 点：
          // 1. 因为 Overlay  默认并不包含 Material，不然下面的内容将会显示处理是黑乎乎的
          // 2. Material 可以设定 elevation，本例我们需要阴影效果。
          child: Material(
            elevation: 4.0,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: const <Widget>[
                ListTile(title: Text('Syria')),
                ListTile(title: Text('Lebanon'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        // 为 Field 指定一个 focusNode 对象，
        // 在 initState() 方法里为 focusNode 对象添加了 listener
        focusNode: _focusNode,
        decoration: const InputDecoration(labelText: 'Country'),
      ),
    );
  }
}
