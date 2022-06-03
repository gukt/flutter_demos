import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MaterialApp(home: Scaffold(body: Home())));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? years;
  String? unit;
  final Debouncer debouncer = Debouncer(const Duration(milliseconds: 200));

  void _showYearsPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 300,
          child: CupertinoPicker(
            itemExtent: 28,
            useMagnifier: true,
            magnification: 1.2,
            onSelectedItemChanged: (index) {
              debugPrint('Selected: $index');
              debouncer.run(() {
                setState(() => years = '$index 年');
              });
            },
            children: List.generate(30, (index) {
              return Center(child: Text('$index 年'));
            }),
          ),
        );
      },
    );
  }

  void _showUnitPicker() {
    var units = ['元', '万元'];
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 300,
          child: CupertinoPicker(
            itemExtent: 28,
            useMagnifier: true,
            magnification: 1.2,
            onSelectedItemChanged: (index) {
              debugPrint('Selected: $index');
              debouncer.run(() {
                setState(() => unit = units.elementAt(index));
              });
            },
            children: units.map((e) => Text(e)).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('贷款总额'),
            trailing: GestureDetector(
              onTap: _showUnitPicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: '0',
                          suffixIcon: GestureDetector(
                            onTap: _showUnitPicker,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(unit ?? '元'),
                            ),
                          ),
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 0, minHeight: 0),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                          ),
                          border: InputBorder.none,
                          // border: const UnderlineInputBorder(),
                        )),
                  ),
                  const AnimatedDropDownIcon(),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('贷款年限'),
            trailing: GestureDetector(
              onTap: _showYearsPicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(years ?? '请选择'),
                  GestureDetector(
                      onTap: _showYearsPicker,
                      child: const Icon(Icons.keyboard_arrow_right_rounded)),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('前置费用'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                    width: 100,
                    child: TextField(
                      textAlign: TextAlign.right,
                    )),
                SizedBox(width: 4),
                Text('元'),
                SizedBox(width: 8),
              ],
            ),
          ),
          const Divider(height: 1),
          const ListTile(
            title: Text('还款方式'),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class AnimatedDropDownIcon extends StatefulWidget {
  const AnimatedDropDownIcon({Key? key, this.duration}) : super(key: key);

  final Duration? duration;

  @override
  State<AnimatedDropDownIcon> createState() => _AnimatedDropDownIconState();
}

class _AnimatedDropDownIconState extends State<AnimatedDropDownIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      lowerBound: 0,
      upperBound: math.pi,
      duration: widget.duration ?? const Duration(microseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.isDismissed) {
          controller.forward();
        } else if (controller.isCompleted) {
          controller.reverse();
        }
      },
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: controller.value,
              child: const Icon(Icons.arrow_drop_down_rounded),
            );
          }),
    );
  }
}

/// 防抖器，默认延时 800 毫秒
class Debouncer {
  Debouncer([this.delay = const Duration(milliseconds: 100)]);

  final Duration delay;
  Timer? _timer;

  void run(void Function() action) {
    // 移除之前的 timer（如果有）
    cancel();
    // 创建一个新的定时器，执行延时 action
    _timer = Timer(delay, action);
  }

  bool get isRunning => _timer?.isActive ?? false;

  void cancel() => _timer?.cancel();
}
