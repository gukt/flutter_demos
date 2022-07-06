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
//             // MonthPicker 是一个 StatefulWidget，它已经被废弃了，请使用 CalendarDatePicker 代替
//             // 默认显示一个日历
//             // 这个 Widget 的确容易混淆，既然叫 MonthPicker 但显示的是一个日历，并且可以选择到具体的每日，很容易造成理解上的混淆，所以不要使用它
//             child: MonthPicker(
//               // firstDate 和 lastDate 定义可选的区间
//               // 超出范围呈现禁用状态
//               firstDate: DateTime(2022, 5, 15),
//               lastDate: DateTime(2022, 6, 31),
//               // 当前选择的日期，必须是一个变量，
//               // 改变这个变量值后，界面上选中状态才会发生变更。
//               // 选中的日期会高亮显示，默认蓝色圆形背景
//               selectedDate: time,
//               dragStartBehavior: DragStartBehavior.down,
//               // 当用户选择发生变更时回调
//               onChanged: (DateTime value) {
//                 debugPrint('MonthPicker:$value');
//                 setState(() => time = value);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
