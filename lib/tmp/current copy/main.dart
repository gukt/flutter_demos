// import 'package:flutter/material.dart';

// /// https://flutter.cn/docs/cookbook/effects/gradient-bubbles
// void main() => runApp(const MaterialApp(home: Home()));

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// @immutable
// class BubbleBackground extends StatelessWidget {
//   const BubbleBackground({
//     Key? key,
//     required this.colors,
//     this.child,
//   }) : super(key: key);

//   final List<Color> colors;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: BubblePainter(
//         colors: colors,
//         bubbleContext: context,
//         scrollable: ScrollableState(),
//       ),
//       child: child,
//     );
//   }
// }

// class BubblePainter extends CustomPainter {
//   BubblePainter({
//     required ScrollableState scrollable,
//     required BuildContext bubbleContext,
//     required List<Color> colors,
//   })  : _scrollable = scrollable,
//         _bubbleContext = bubbleContext,
//         _colors = colors;

//   final ScrollableState _scrollable;
//   final BuildContext _bubbleContext;
//   final List<Color> _colors;

//   @override
//   bool shouldRepaint(BubblePainter oldDelegate) {
//     return oldDelegate._scrollable != _scrollable ||
//         oldDelegate._bubbleContext != _bubbleContext ||
//         oldDelegate._colors != _colors;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
//     final scrollableRect = Offset.zero & scrollableBox.size;
//     final bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

//     final origin =
//         bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
//     final paint = Paint()
//       ..shader = Gradient.linear(
//         scrollableRect.topCenter,
//         scrollableRect.bottomCenter,
//         _colors,
//         [0.0, 1.0],
//         TileMode.clamp,
//         Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
//       );
//     canvas.drawRect(Offset.zero & size, paint);
//   }
// }
