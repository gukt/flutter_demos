import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// GestureDetector 演示
/// See also:
/// - [GestureDetector - 老孟](http://laomengit.com/flutter/widgets/GestureDetector.html#gesturedetector)
///
void main() => runApp(const MaterialApp(home: Home()));

/// 1. 如果希望捕捉按下或松开动作，而不是移动，请使用 onTap-* 相关回调。
/// - onTapDown - 轻触时触发，只有有轻触总是会触发。
/// - onTapUp - 轻触后松开时触发，如果轻触后接触点发生了移动，则不会触发该回调，而是触发 onTapCancel。
/// - onPanCancel - 轻触后发生了移动时触发。
/// - onTap - 轻触后松开时触发，如果同时也定义了 onTapUp，则 onTapUp 发生在 onTap 之前
/// - onDoubleTap - 同一位置连续两次点击时触发，如果同时绑定了 onTap 和 onDoubleTap，则系统会先触发 onTap，然后经过一小段时间看看是否是两次点击，如果是两次，则继续触发 onDoubleTap。
///
/// 2. 如果要捕捉移动相关的手势，请使用 onPan-*，如果同时指定了 onPanDown 和 onTapDown 则 onPanDown 发生在 onTapDown 之前。
/// - onPanDown - 按下时回调，可能将要移动，如果随后开始移动了，则紧随着触发 onPanStart；如果没有一定立即松开手指，则接着触发 onPanCancel。
/// - onPanStart - 按下后开始移动时触发
/// - onPanEnd - 停止移动后触发
/// - onPanCancel - 按下后，但没有移动时触发
/// - onPanUpdate - 移动时总是触发
///
/// 3. 长按事件（LongPress）包含长按开始、移动、抬起、结束事件.
/// - onLongPress - 长按时回调。如果同时指定了 onPanDown 和 onTapDown，则 onLongPressDown 发生顺序为：onPanDown > onLongPressDown > onTapDown；如果以下事件同时都指定，则发生顺序为：onLongPressDown > onLongPressStart > onLongPress > onLongPressEnd > onLongPressUp
/// - onLongPressDown - 长按开始时回调。
/// - onLongPressUp - 长按松开后回调。
/// - onLongPressCancel - 长按后发生了触点移动时回调。
/// - onLongPressStar - 长按开始事件回调。
/// - onLongPressEnd - 长按结束事件回调。
/// - onLongPressMoveUpdate - 长按移动事件回调。
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          //
          // onTap-*
          //
          onTapDown: (TapDownDetails tapDownDetails) {
            debugPrint('onTapDown');
          },
          onTapUp: (TapUpDetails tapUpDetails) {
            debugPrint('onTapUp');
          },
          onTap: () {
            debugPrint('onTap');
          },
          onTapCancel: () {
            debugPrint('onTapCancel');
          },
          onDoubleTap: () {
            debugPrint('onDoubleTap');
          },
          //
          // onPan-*
          //
          onPanDown: (details) {
            debugPrint('onPanDown');
          },
          onPanStart: (details) {
            debugPrint('onPanStart');
          },
          onPanEnd: (details) {
            debugPrint('onPanEnd');
          },
          onPanCancel: () {
            debugPrint('onPanCancel');
          },
          onPanUpdate: ((DragUpdateDetails details) {
            debugPrint('onPanUpdate');
          }),
          //
          // onLongPress-*
          //
          onLongPress: () {
            debugPrint('onLongPress');
          },
          onLongPressDown: (LongPressDownDetails details) {
            debugPrint('onLongPressDown');
          },
          onLongPressUp: () {
            debugPrint('onLongPressUp');
          },
          onLongPressCancel: () {
            debugPrint('onLongPressCancel');
          },
          onLongPressStart: (LongPressStartDetails details) {
            debugPrint('onLongPressStart');
          },
          onLongPressEnd: (LongPressEndDetails details) {
            debugPrint('onLongPressEnd');
          },
          onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
            debugPrint('onLongPressMoveUpdate');
          },
          //
          // 其他的还有 onScale-*、onVerticalDrag-*、onVerticalDrag-*、onHorizontalDrag-* 都是很类似。
          //
          child: Container(
            width: 100,
            height: 100,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
