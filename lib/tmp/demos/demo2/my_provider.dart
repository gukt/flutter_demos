// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// Type _typeOf<T>() => T;

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Material App Bar'),
//         ),
//         body: Center(
//           child: Container(
//             child: Text('Hello World'),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class InheritedProvider<T> extends InheritedWidget {
//   final T data;

//   const InheritedProvider({
//     Key? key,
//     required this.data,
//     required Widget child,
//   }) : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(InheritedProvider oldWidget) {
//     // 在此简单返回 true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
//     return true;
//   }
// }

// class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
//   final Widget child;
//   final T data;

//   const ChangeNotifierProvider({
//     Key? key,
//     required this.data,
//     required this.child,
//   }) : super(key: key);

//   static T of<T>(BuildContext context) {
//     // final type = _typeOf<InheritedProvider<T>>();
//     final provider =
//         context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
//     return provider!.data;
//   }

//   @override
//   State<ChangeNotifierProvider<T extends ChangeNotifier>> createState() => _ChangeNotifierProviderState<T extends ChangeNotifier>();
// }

// class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

// class MyModel extends ChangeNotifier {}
