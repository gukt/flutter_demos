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
  var time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time.toString()),
            ElevatedButton(
              child: const Text('选择时间'),
              onPressed: () async {
                // 这种 Material 风格的时间选择，感觉不太好看，一般使用 CupertinoDatePicker, CupertinoTimePicker
                // 选中的时间可通过函数返回值获得
                var value = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020, 5, 15),
                  lastDate: DateTime(2023, 7, 31),
                );
                setState(() {
                  time = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
