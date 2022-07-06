import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({
    Key? key,
    this.height = 300,
    required this.child,
    this.label,
  }) : super(key: key);

  final double height;
  final Widget child;
  final String? label;

  @override
  Widget build(BuildContext context) {
    // 图表要限定高度的，不然会报错
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: label != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label!, style: const TextStyle(fontSize: 14)),
                    Expanded(child: child),
                  ],
                )
              : child,
        ),
      ),
    );
  }
}
