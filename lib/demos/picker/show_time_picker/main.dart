import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// showDateTimerPicker
/// CupertinoDatePicker
/// CupertinoTimerPicker
/// CupertinoPicker
/// DatePickerDialog
/// TimePickerDialog
/// MonthPicker
/// DayPicker
/// YearPicker
/// CalendarDatePicker
///
/// See also:
/// 1. http://laomengit.com/flutter/widgets/DatePicker.html
void main() => runApp(const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      locale: Locale('zh'),
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            // 注意：在页面中直接使用 TimePickerDialog 是不建议的，这里只是一个演示说明
            // 这是 Material 风格的 StatefulWidget
            // 它默认显示一个对话框，一般不直接将其嵌入到页面中，而是将其和 showDialog 配合使用，Flutter 为我们提供了 showTimePicker 内部就是用的这个 TimePickerDialog
            // 对话框的顶部显示“选择时间”一行小字
            // 接着是选择“上午、下午” + 时间（时 + 分）
            // 点击“时”或“分”，下面的表盘会跟随变化，你可以通过下面的表盘来选择时间
            // 底部左边是一个键盘按钮，点击页面切换为“输入状态”，你可以直接手动输入时间
            // 底部右边显示“取消 + 确定”按钮
            child: TimePickerDialog(
              initialTime: TimeOfDay.now(),
            ),
          ),
          Text(time.toString()),
          ElevatedButton(
            child: const Text('选择时间'),
            onPressed: () async {
              // 选中的时间可通过函数返回值获得
              var value = await showTimePicker(
                context: context,
                initialTime: time,
              );
              setState(() {
                time = value ?? TimeOfDay.now();
              });
            },
          )
        ],
      ),
    );
  }
}
