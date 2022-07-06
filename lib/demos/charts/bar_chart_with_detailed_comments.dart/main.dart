import 'package:flutter/material.dart';
// 引入 charts_flutter 框架（google 出品），一般给一个别名 charts(官方例子就是这么用的)
import 'package:charts_flutter/flutter.dart' as charts;

/// 柱状图示例。
///
/// 本实例参考了 https://medium.com/flutter/beautiful-animated-charts-for-flutter-164940780b8c 对其做了一点修改。
///
/// 本实例演示了：
/// - 图表中的某个年份数值是根据 counter 计数值显示的，点击右下角按钮可以更改计数值
/// - 图表的数值变化会有动画效果
/// - 图表的 y 轴显示数据会根据相关数据的增长自动变化。
/// - 如何将轴上的标签进行旋转显示，以避免重叠。
///
/// See also:
/// - [官方的 Charts Gallery](https://google.github.io/charts/flutter/gallery.html)
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final List<PaymentModel> data = [
      PaymentModel('2016', 12, 10),
      PaymentModel('2017', 42, 32),
      PaymentModel('2018', _counter + 5, _counter),
    ];

    // 图标概念：
    // domain - 被观察的事务，例如：车辆的类型
    // measure - 观察到的数值：例如：车轮数
    // Data point - 域的度量；例如，（'汽车'，4）。有时称为基准。
    // Series - 单个数据点（Data point）的有序集合；例如[('car', 4), ('bicycle', 2)]
    // Id - 单个系列的唯一标识符；用于呈现多个系列的图表；例如“典型车轮数”和“最大车轮数”
    final List<charts.Series<PaymentModel, String>> series = [
      // Series 的泛型参数 T，D 分别对应：数据类型，domain 返回值类型
      // Series 表示一类数据的序列，比如要显示 12 个月的利息和本金对比图
      // 则应该提供两个 Series，其中之一的 Series 的 data 数据应该是“本金”数据，
      // 另外一个 Series 的 data 数据是 “利息”数据
      // 这个序列定义“本金” 相关属性
      charts.Series<PaymentModel, String>(
        id: '本金',
        // 将‘年’设置为 domain（即横坐标，x 轴显示的事物）
        domainFn: (PaymentModel pmt, _) => pmt.year,
        // 将 ‘clicks’ (点击数)设置为纵坐标（y）显示的数据
        measureFn: (PaymentModel pmt, _) => pmt.principle,
        // 显示的颜色，注意：这里返回的 Color 是 charts 自己定义的 Color 类，而我们传入数据中的 color 属性是 dart 的 ui 包中定义的 Color对象，所以需要通过 ColorUtil.fromDartColor 转换一下。
        colorFn: (_a, _b) => charts.ColorUtil.fromDartColor(Colors.green),
        data: data,
      ),
      // 这个序列定义“利息” 相关属性
      charts.Series<PaymentModel, String>(
        id: '利息',
        // 将‘年’设置为 domain（即横坐标，x 轴显示的事物）
        domainFn: (PaymentModel pmt, _) => pmt.year,
        // 将 ‘clicks’ (点击数)设置为纵坐标（y）显示的数据
        measureFn: (PaymentModel pmt, _) => pmt.interest,
        colorFn: (_a, _b) =>
            charts.ColorUtil.fromDartColor(Colors.pink.shade100),
        // 注意这个 data 的概念不要和 Series 搞混淆了
        // 对于图表来说，假设有 12 个月，则每个月的数据就是一个 Series 实例
        // 而每个月中，如果要显示多根柱子数据，这这多根柱子的数据就来自于下面这个 data 属性
        data: data,
      ),
    ];
    // 接下来，我们定义BarChart 控件
    var chart = charts.BarChart(series, animate: true);

    // 图表要限定高度的，不然会报错
    var chartWidget = Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(height: 200.0, child: chart),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('柱状图演示')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          chartWidget,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PaymentModel {
  final String year;

  /// 本金
  final int principle;

  /// 利息
  final int interest;

  PaymentModel(this.year, this.principle, this.interest);
}
