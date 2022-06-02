import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// See also:
/// 1. http://laomengit.com/flutter/widgets/DatePicker.html
void main() => runApp(const MaterialApp(
      // No MaterialLocalizations found.
      // No CupertinoLocalizations found.
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
  var _time;
  DateTime _now = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // 显示一个对话框，该对话框包含 Material 设计风格日期选择器
                // showDatePicker 是一个包装过的全局方法，它将弹出一个自定义的对话框，有标题和底部的取消，确定按钮，内容是用 CalendarDatePicker Widget 实现的。
                var dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2016),
                  lastDate: DateTime(2023),
                );
                setState(() => _time = dateTime.toString());
              },
              child: Text(_time ?? '选择日期'),
            ),
            Expanded(
              child: TimePickerDialog(
                initialTime: TimeOfDay.now(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() => _time = timeOfDay.toString());
              },
              child: Text(_time ?? '选择时间'),
            ),
            ElevatedButton(
              onPressed: () {
                showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2022, 5, 1),
                  lastDate: DateTime(2023, 5, 1),
                );
              },
              child: Text(_time ?? '选择时间'),
            ),
            // Expanded(
            //   child: CalendarDatePicker(
            //     initialDate: DateTime.now(),
            //     firstDate: DateTime(2016),
            //     lastDate: DateTime(2023),
            //     initialCalendarMode: DatePickerMode.year,
            //     onDateChanged: (DateTime value) {},
            //   ),
            // ),
            Expanded(
              // 构建一个 IOS 风格的日期选择器，可以选择：月、日、时、分
              child: CupertinoDatePicker(
                // 显示初始日期和时间，默认 null，为 null 时显示当前时间
                // initialDateTime: _now.add(const Duration(days: 3)),
                // 是否使用 24 小时格式，默认 false，如果为 true，则不会显示'上午，下午'，且 hours 列会按 24 小时显示
                use24hFormat: true,
                // 默认显示 dateAndTime, 还有两个选项
                // date: 只能选择日期
                // time: 只能选择时间
                mode: CupertinoDatePickerMode.dateAndTime,
                // 设置分钟间隔，要确保 initialDateTime 中的分钟和这里设置的数值可以整除，否则报错。
                // minuteInterval: 5,
                // 控制列的显示顺序(从左到右)，默认为区域设置的默认日期格式/顺序
                dateOrder: DatePickerDateOrder.ymd,
                backgroundColor: Colors.grey[200],
                onDateTimeChanged: (DateTime value) {
                  debugPrint('CupertinoDatePicker: $value');
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // showDialog(
                //     context: context,
                //     builder: (_) {
                //       return CupertinoDatePicker(
                //         initialDateTime: _now,
                //         use24hFormat: true,
                //         dateOrder: DatePickerDateOrder.ymd,
                //         onDateTimeChanged: (value) {},
                //       );
                //       // return AlertDialog(
                //       //   title: Text('请选择时间'),
                //       //   content: CupertinoDatePicker(
                //       //     initialDateTime: _now,
                //       //     onDateTimeChanged: (DateTime value) {},
                //       //   ),
                //       //   actions: [
                //       //     ElevatedButton(
                //       //       child: const Text('取消'),
                //       //       onPressed: () {
                //       //         Navigator.pop(context);
                //       //       },
                //       //     ),
                //       //     ElevatedButton(
                //       //       child: const Text('确定'),
                //       //       onPressed: () {
                //       //         Navigator.pop(context);
                //       //       },
                //       //     ),
                //       //   ],
                //       // );
                //     });
              },
              child: const Text('CupertinoDatePicker'),
            ),
            // SizedBox(
            //   height: 300,
            //   child: DayPicker(
            //     selectedDate: _selectedDate,
            //     currentDate: DateTime.now(),
            //     onChanged: (date) {
            //       setState(() {
            //         _selectedDate = date;
            //       });
            //     },
            //     firstDate: DateTime(2020, 5, 1),
            //     lastDate: DateTime(2020, 5, 31),
            //     displayedMonth: DateTime(2020, 5),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: ((_) {
                    return const TimePickerDemoPage();
                  })),
                );
              },
              child: const Text("Go Time Picker Demo Page"),
            ),
            ElevatedButton(
              // DayPicker 已经被弃用了，使用 CalendarDatePicker 代替
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Material(
                          child: DayPicker(
                            selectedDate: _selectedDate,
                            currentDate: DateTime.now(),
                            onChanged: (date) {
                              debugPrint('data: $date');
                              setState(() {
                                _selectedDate = date;
                              });
                            },
                            firstDate: DateTime(2020, 5, 1),
                            lastDate: DateTime(2023, 5, 31),
                            displayedMonth: DateTime(2020, 5),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                _time ?? '选择时间',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimePickerDemoPage extends StatefulWidget {
  const TimePickerDemoPage({Key? key}) : super(key: key);

  @override
  State<TimePickerDemoPage> createState() => _TimePickerDemoPageState();
}

class _TimePickerDemoPageState extends State<TimePickerDemoPage> {
  var time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimePickerDemoPage'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              // 构建一个 IOS 风格的时间选择器，可以选择：时、分、秒
              // CupertinoTimerPicker 默认不限宽高，如果要显示其宽高
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
                  setState(() {
                    time = value;
                  });
                },
              ),
            ),
            Text(time?.toString() ?? '未选择'),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    // backgroundColor: Colors.grey,
                    builder: (_) {
                      return Container(
                        // height: 400,
                        // width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ListTile(
                            //   dense: true,
                            //   leading: TextButton(
                            //     onPressed: () {},
                            //     child: const Text("取消"),
                            //   ),
                            //   trailing: TextButton(
                            //     onPressed: () {},
                            //     child: const Text("确定"),
                            //   ),
                            // ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]!),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "取消",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("确定"),
                                  ),
                                  // Text(
                                  //   '取消',
                                  //   style: TextStyle(color: Colors.grey),
                                  // ),
                                  // Text(
                                  //   '确定',
                                  //   style: TextStyle(color: Colors.blue),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: CupertinoTimerPicker(
                                onTimerDurationChanged: (Duration value) {},
                              ),
                              // child: CupertinoDatePicker(
                              //   initialDateTime: _now,
                              //   use24hFormat: true,
                              //   dateOrder: DatePickerDateOrder.ymd,
                              //   // backgroundColor: Colors.amber,
                              //   onDateTimeChanged: (value) {},
                              // ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(time?.toString() ?? '请指定时间'),
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
