import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('构建一个有验证判断的表单'),
      ),
      body: const HomePage(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('导航到 Form 表单页'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormPage(),
            ),
          );
        },
      ),
    );
  }
}

// 定义一个自定义的 Form 组件
class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

// 这里自定义 Form 组件关联的 State 类
// 该类用于保存表单相关的数据
class _FormPageState extends State<FormPage> {
  // 创建一个 Global Key 用于唯一鉴别自定义表单组件，且用于验证表单
  // NOTE: GlobalKey 的泛型类型是 FormState, 不是 _MyFormState
  // State 子类中定义的字段一般使用 final 修饰，且是私有的（_开头）
  // Tips: 一般情况下，推荐使用 GlobalKey 来访问一个表单。嵌套组件且组件树比较复杂的情况下，可以使用 Form.of() 方法访问表单
  // FormState 对象可以用来 save, reset, validate 所有的 FormField
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // 返回一个 Form 组件，该组件使用上面定义的 Global Key.
    return Scaffold(
      appBar: AppBar(
        title: const Text('表单页'),
      ),
      // 关于 Form 的文档：https://flutterchina.club/widgets/input/
      body: Form(
        key: _formKey,
        // 当用户想放弃表单编辑时，我们可能希望弹出一个询问对话框
        // 这种场景需求就可以使用 Form 对象的 onWillPop 来实现，
        // 它的类型是 Future<bool> Function()，
        // 如果 future 的计算结果为 false 表示当前表单所在的路由页面不允许被 Pop。
        onWillPop: () async {
          debugPrint('onWillPop...');
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
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('确认'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          children: [
            // 这里添加表单输入框以及按钮等
            TextFormField(
              // 当所属 Form 对象的 FormState.save() 调用时才会触发该方法
              onSaved: (value) {
                debugPrint('onSaved: $value');
              },
              // 指定一个验证函数，用于对用户表单输入的内容进行验证
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入一些内容';
                }
                return null;
              },
            ),
            // 创建完输入框字段后，还需要提供一个按钮让用户提交表单
            // 这里添加一个 ElevatedButton，它是一个浮动效果的按钮，对应的其他按钮还有 TextButton
            //
            ElevatedButton(
              onPressed: () {
                // 在这里触发表单的提交和验证
                // 如果表单验证通过，则 validate 函数会返回 true
                if (_formKey.currentState!.validate()) {
                  // 如果表单通过验证，则显示一个 snack bar。
                  // 在真实应用中，这里一般就要提交表单数据到服务器
                  // SnackBar 是一个底部弹出的，横向填满的，类似 toast 的提示信息，
                  // 它的默认样式是深灰色背景，白色文字
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Processing Data'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
