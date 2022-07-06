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
//             // YearPicker 是一个 StatefulWidget，
//             // 默认显示 3列 6 行的年份
//             // 可以对齐限定一个高度（ 比如使用 SizedBox
//             //）,当高度小于实际内容高度时，内容可以滚动。当仍然是 3列 * 6行
//             child: YearPicker(
//               // firstDate 和 lastDate 定义可选的年份区间
//               // 超出范围的年份呈现禁用状态
//               firstDate: DateTime(2020),
//               lastDate: DateTime(2023),
//               // 当前选择的日期，必须是一个变量，
//               // 改变这个变量值后，界面上选中状态才会发生变更。
//               selectedDate: time,
//               dragStartBehavior: DragStartBehavior.down,
//               // 当用户选择发生变更时回调
//               onChanged: (DateTime value) {
//                 debugPrint('YearPicker:$value');
//                 setState(() => time = value);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
