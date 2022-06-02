import 'package:flutter/cupertino.dart';
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
  Duration _duration = const Duration(
    hours: 1,
    minutes: 2,
    seconds: 3,
  );
  var _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CupertinoDatePicker(
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _date = value;
                  });
                },
              ),
            ),
            Expanded(
              // 构建一个 IOS 风格的时间选择器，可以选择：时、分、秒
              // CupertinoTimerPicker 默认不限宽高，如果要显示其宽高
              // 你可以将其直接嵌入到页面中，但一般不这么用，而是放到 dialog 或  showBottomSheet 中
              child: CupertinoTimerPicker(
                // 可以通过 mode 设置只显示 '时+分'（hm）或只显示 '分+秒'(ms)，默认：hms(时分秒)
                // mode: CupertinoTimerPickerMode.hm,
                // 设定初始值
                initialTimerDuration: const Duration(
                  hours: 1,
                  minutes: 10,
                  seconds: 5,
                ),
                // 分钟间隔，这里设置为 2，则分钟就只会显示偶数
                // 注意，initialTimerDuration 中设置的 minutes 要能和这里设置的值整除
                minuteInterval: 2,
                // 秒间隔，这里设置为 5，则秒就只会显示 0,5,10,15
                // 注意，initialTimerDuration 中设置的 seconds 要能和这里设置的值整除
                secondInterval: 5,
                // 控制 TimerPicker 在父组件中的对齐方式，默认居中
                // alignment: Alignment.center,
                // 背景颜色，默认 null，表示禁用背景绘制
                backgroundColor: Colors.grey[300],
                // 当选择变更时回调
                onTimerDurationChanged: (Duration value) {
                  debugPrint('CupertinoTimerPicker: $value');
                  setState(() => _duration = value);
                },
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    // backgroundColor: Colors.grey,
                    builder: (_) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            dense: true,
                            leading: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "取消",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("确定"),
                            ),
                          ),
                          const Divider(height: 1),
                          SizedBox(
                            height: 300,
                            child: CupertinoDatePicker(
                              initialDateTime: _date,
                              use24hFormat: true,
                              dateOrder: DatePickerDateOrder.ymd,
                              // backgroundColor: Colors.amber,
                              onDateTimeChanged: (DateTime value) {
                                _date = value;
                              },
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_duration.toString()),
                  const Icon(Icons.arrow_drop_down_sharp)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
