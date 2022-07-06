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
//             // DayPicker 是一个 StatefulWidget，它已经被废弃了，请使用 CalendarDatePicker 代替
//             // 默认显示一个日历
//             // 这中日历方式选择每一天，占用的面积较大，手机上体验不太好，一般不使用这种方式，而是使用 CupertinoTimePicker 那种齿轮滚动方式，且放到一个 Dialog 或 BottomSheet 中效果会更好
//             child: DayPicker(
//               // firstDate 和 lastDate 定义可选的区间
//               // 超出范围呈现禁用状态
//               firstDate: DateTime(2022, 5, 15),
//               lastDate: DateTime(2022, 7, 31),
//               currentDate: DateTime.now(),
//               // 用来限定日历的月份，和 MonthPicker 不同的是 DayPicker 限定了月份，只能在指定的月份内选择那一天
//               displayedMonth: DateTime(2022, 6),
//               // 当前选择的日期，必须是一个变量，
//               // 改变这个变量值后，界面上选中状态才会发生变更。
//               // 选中的日期会高亮显示，默认蓝色圆形背景
//               selectedDate: time,
//               dragStartBehavior: DragStartBehavior.down,
//               // 当用户选择发生变更时回调
//               onChanged: (DateTime value) {
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
