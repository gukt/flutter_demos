import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/bottom_to_top_faded_transition.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_faded_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/animations/rotate_animation_transition.dart';
import 'package:page_animation_transition/animations/scale_animation_transition.dart';
import 'package:page_animation_transition/animations/top_to_bottom_faded.dart';
import 'package:page_animation_transition/animations/top_to_bottom_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

/// 页面转场效果演示
///
/// 使用第三方包：https://pub.dev/packages/page_animation_transition
void main() => runApp(const MaterialApp(home: First()));

class First extends StatelessWidget {
  const First({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('页面转场效果演示'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: BottomToTopTransition()));
                },
                child: const Text('Bottom To Top')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: TopToBottomTransition()));
                },
                child: const Text('Top to bottom')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: RightToLeftTransition()));
                },
                child: const Text('Right To Left')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: LeftToRightTransition()));
                },
                child: const Text('Left to Right')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: FadeAnimationTransition()));
                },
                child: const Text('Faded')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: ScaleAnimationTransition()));
                },
                child: const Text('Scale')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: RotationAnimationTransition()));
                },
                child: const Text('Rotate')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: TopToBottomFadedTransition()));
                },
                child: const Text('Top to Bottom Faded')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: BottomToTopFadedTransition()));
                },
                child: const Text('Bottom to Top Faded')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: RightToLeftFadedTransition()));
                },
                child: const Text('Right to Left Faded')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(PageAnimationTransition(
                      page: const Second(),
                      pageAnimationType: LeftToRightFadedTransition()));
                },
                child: const Text('Left to Right Faded')),
          ],
        ),
      ),
    );
  }
}

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page2'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back')),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Second(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
