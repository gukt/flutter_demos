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
  var time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            // 注意：在页面中直接使用 TimePickerDialog 是不建议的，这里只是一个演示说明
            // 之类在页面中嵌套这个 TimePickerDialog，用户点击'取消'时会回退到上一个路由，这显然不是我们期望的。
            // 这是 Material 风格的 StatefulWidget
            // 该对话框比起直接使用 CalendarDatePicker 有了顶部标题 + 底部按钮，并且可以切换到手动输入状态，直接使用 CalendarDatePicker 没有 showDatePicker 交互丰富
            child: DatePickerDialog(
              firstDate: DateTime(2020, 5, 15),
              lastDate: DateTime(2023, 7, 31),
              initialDate: time,
            ),
          ),
          Text(time.toString()),
          ElevatedButton(
            child: const Text('选择时间'),
            onPressed: () async {
              // 这种 Material 风格的时间选择，感觉不太好看，一般使用 CupertinoDatePicker, CupertinoTimePicker
              // 选中的时间可通过函数返回值获得
              var value = await showDatePicker(
                context: context,
                firstDate: DateTime(2020, 5, 15),
                lastDate: DateTime(2023, 7, 31),
                initialDate: time,
                // 还有其他很多属性，都很简单，不再赘述
              );
              setState(() {
                time = value ?? DateTime.now();
              });
            },
          )
        ],
      ),
    );
  }
}
