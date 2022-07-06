// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_picker/flutter_picker.dart';

// /// showDateTimerPicker
// /// CupertinoDatePicker
// /// CupertinoTimerPicker
// /// CupertinoPicker
// /// DatePickerDialog
// /// TimePickerDialog
// /// DayPicker
// /// YearPicker
// /// CalendarDatePicker
// ///
// /// See also:
// /// 1. http://laomengit.com/flutter/widgets/DatePicker.html
// void main() => runApp(const MaterialApp(
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: [
//         Locale('zh', 'CH'),
//         Locale('en', 'US'),
//       ],
//       locale: Locale('zh'),
//       home: Home(),
//     ));

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   var time = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             // 这是 Material 风格的 StatefulWidget
//             // 它默认显示一个日历，左上角带下拉箭头的年月，点击可进入选择年份
//             // 右上角有两个左右箭头，用来切换所在年的月份
//             // 该 Widget 用来替代旧的 YearPicker, MonthPicker, DayPicker 的，更紧凑直观。
//             // Flutter 中并没有提供诸如 TimePicker 或 CalendarTimePicker 之类的 Widget，
//             // 而是提供了 CupertinoTimePicker，这个 Widget 会显示一个 IOS 风格的时间选择 Widget，它是一个显示“时+分+上午/下午” 或 “时+分（24 小时制）”的类似齿轮滚动效果的那种选择器
//             // 另外也提供了一个 TimePickerDialog,  它是一个 Material 风格的时间选择器，并且是一个 dialog，一般不会将其嵌入到页面中使用，而是作为对话框的内容，你可以调用 showTimeDialog() 来展现该时间选择器。请看另外一个 demo。
//             child: CalendarDatePicker(
//               // firstDate 和 lastDate 定义可选的区间
//               // 超出范围呈现禁用状态
//               firstDate: DateTime(2020, 5, 15),
//               lastDate: DateTime(2023, 7, 31),
//               initialDate: time,
//               currentDate: DateTime.now(),
//               // 初始日历模式，默认 DatePickerMode.day
//               // 如果换成 year ，则显示的是 3 * 5 的年份二维表格
//               initialCalendarMode: DatePickerMode.year,
//               onDateChanged: (DateTime value) {
//                 debugPrint('DayPicker:$value');
//                 setState(() => time = value);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
