import 'package:flutter/material.dart';

/// 示例代码：[构建一个有验证判断的表单](https://flutter.cn/docs/cookbook/forms/validation)
///
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 创建一个 GlobalKey 用来唯一鉴别 Form Widget 并且允许表单验证
  // 注意: 这里是 `GlobalKey<FormState>`, 而不是 GlobalKey<_CustomFormState>.
  // 推荐使用 GlobalKey 来访问一个表单。
  // 嵌套组件且组件树比较复杂的情况下，可以使用 Form.of() 方法访问表单
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // 返回一个 Form widget, 它使用上面创建的 _formKey
    return Scaffold(
      body: Form(
        key: _formKey,
        // 用户想要弹出本页之前执行的回调，如果返回 false，则路由不会被弹出
        onWillPop: () async {
          // 当返回的 Future 执行结果是 false 时，表单不会被关闭。
          // 可以直接返回 Future.value(false/true) 试一试
          // return Future.value(true);
          return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('提示'),
                content: const Text('确认放弃编辑吗？'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('取消'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: const Text('确认'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          children: <Widget>[
            // 添加带验证逻辑的 TextFormField 到表单中
            TextFormField(
              // validator 接受用户输入的文本
              validator: (value) {
                if (value == null || value.isEmpty) {
                  // 直接返回错误文本
                  return '内容不能为空';
                }
                return null;
              },
            ),
            // 创建一个用来提交表单的按钮
            ElevatedButton(
              onPressed: () {
                // 使用 _formKey.currentState() 方法去访问 FormState，而 FormState 是在创建表单 Form 时 Flutter 自动生成的。
                // FormState 类包含了 validate() 方法。当 validate() 方法被调用的时候，会遍历运行表单中所有文本框的 validator() 函数。
                // 如果所有 validator() 函数验证都通过，validate() 方法返回 true。
                // 如果有某个文本框验证不通过，就会在那个文本框区域显示错误提示，同时 validate() 方法返回 false。
                if (_formKey.currentState!.validate()) {
                  // 如果表单验证无误，显示一个 Snackbar。
                  // 在真实场景中，一般是调用服务器  API 保存数据到数据库
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('正在处理...')),
                  );
                }
              },
              child: const Text('提交'),
            ),
          ],
        ),
      ),
    );
  }
}
