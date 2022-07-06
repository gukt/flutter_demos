import 'dart:math';

import 'package:flutter/material.dart';
// 引入 charts_flutter 框架（google 出品），一般给一个别名 charts(官方例子就是这么用的)
import 'package:charts_flutter/flutter.dart' as charts;

import 'chart_container.dart';
import 'models.dart';

List<OrdinalSales> generateRandomSalesData(int size) {
  final random = Random();
  return List.generate(
    size,
    (index) => OrdinalSales(
      (index + 2000).toString(),
      random.nextInt(1000),
    ),
  );
}

charts.Color randomColor() {
  final random = Random();
  return charts.ColorUtil.fromDartColor(
    Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      0.8,
    ),
  );
}

/// 柱状图示例。
/// 图表概念：
/// - domain - 被观察的事务，例如：车辆的类型
/// - measure - 观察到的数值：例如：车轮数
/// - Data point - 域的度量；例如，（'汽车'，4）。有时称为基准。
/// - Series - 单个数据点（Data point）的有序集合；例如[('car', 4), ('bicycle', 2)]
/// - Id - 单个系列的唯一标识符；用于呈现多个系列的图表；例如“典型车轮数”和“最大车轮数”
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
  bool vertical = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('text')),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ChartContainer(
              label: '1. 基本饼图',
              height: 400,
              child: PieChart1(),
            ),
            ChartContainer(
              label: '2. 基本饼图 u',
              height: 400,
              child: PieChart2(),
            ),
            ChartContainer(
              label: '1. 垂直显示',
              child: BarChartExample1(),
            ),
            ChartContainer(
              label: '2. 水平显示',
              child: BarChartExample2(),
            ),
            ChartContainer(
              label: '3. 指定柱子颜色',
              child: BarChartExample3(),
            ),
            ChartContainer(
              label: '4. 按组堆叠',
              child: BarChartExample4(),
            ),
            ChartContainer(
              label: '5. 显示标签',
              child: BarChartExample5(),
            ),
            ChartContainer(
              label: '6. 隐藏 domain 和 measure 轴名称以及各个边距',
              child: BarChartExample6(),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartExample1 extends StatelessWidget {
  const BarChartExample1({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    final random = Random();

    List<OrdinalSales> data = List.generate(
      10,
      (index) => OrdinalSales(
        (index + 2000).toString(),
        random.nextInt(1000),
      ),
    );

    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Sales',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        data: data,
      ),
    ];
  }

  /// AxisSpec 专门用于序数轴/非连续轴。
  ///
  /// API: https://pub.dev/documentation/charts_common/latest/common/AxisSpec-class.html
  ///
  /// 继承关系如下：
  /// - DateTimeAxisSpec - 用于时间序列图的通用 AxisSpec。
  ///   - EndPointsTimeAxisSpec - 用于时间序列图表的默认 AxisSpec。
  /// - NumericAxisSpec - 专门用于数字/连续轴，如 Measure Axis (测量轴)
  ///   - BucketingAxisSpec -
  ///   - PercentAxisSpec - 专门用于数字百分比轴。
  /// - OrdinalAxisSpec - 序数轴规范
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      makeSeriesListData(),
      animate: true,
      // 定义 domain 轴的规范，这里使用 OrdinalAxisSpec (序数轴规范)
      // 如果要隐藏 domain axis，请使用一下用法：
      // domainAxis: const charts.OrdinalAxisSpec(
      //   renderSpec: charts.NoneRenderSpec(),
      // ),
      domainAxis: charts.OrdinalAxisSpec(
        // 是否显示轴线，默认 true
        showAxisLine: true,
        // 生成规范，这里指定为 SmallTickRendererSpec
        renderSpec: charts.SmallTickRendererSpec(
          // 控制 label 旋转角度（避免文字重叠）
          labelRotation: 60,
          // 如果这里大于 0，则会在标签下显示一条指定长度的线（垂直于 x 轴，并且在 x 轴下方）
          // 控制在 domain 轴线以下显示的一条短线的长度（以像素为单位）这条短线从柱子的底部中心点出发，向下延伸。
          tickLengthPx: 5,
          // 定义轴线以及轴线下面与轴线垂直的线的线性颜色，线宽，和线型（dashed）
          lineStyle: charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.green),
            thickness: 1,
            // 定义线型，根据不同的参数，可以定义出虚线或点划线。
            dashPattern: const [1, 2],
          ),
        ),
      ),
    );
  }
}

class BarChartExample2 extends StatelessWidget {
  const BarChartExample2({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    final random = Random();

    List<OrdinalSales> data = List.generate(
      10,
      (index) => OrdinalSales(
        (index + 2000).toString(),
        random.nextInt(1000),
      ),
    );

    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Sales',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      makeSeriesListData(),
      animate: true,
      // 用于控制图表是垂直的还是水平的，默认 true（垂直显示）
      // 如果垂直显示：x 轴为 domain 轴，y 轴为 measure 轴，标签显示默认从左到右。
      // 如果水平显示：y 轴为 domain 轴，x 轴为 measure 轴。标签显示默认从上到下。
      vertical: false,
    );
  }
}

class BarChartExample3 extends StatelessWidget {
  const BarChartExample3({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    final random = Random();

    List<OrdinalSales> data = List.generate(
      8,
      (index) => OrdinalSales(
        (index + 2000).toString(),
        random.nextInt(1000),
      ),
    );

    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Sales',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        // 定义柱子的外边框颜色
        // 注意：需要在 defaultRenderer 中设置 strokeWidthPx 大于 0，不然看不到效果
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        // 定义柱子的填充色
        // 注意：需要在 defaultRenderer 中设置 strokeWidthPx 大于 0，
        // 不然啥也看不到，因为柱子是透明的，而且外边框宽度默认为 0.
        fillColorFn: (_, index) {
          // 这里定义第三根柱子填充色为透明
          return index == 2
              ? charts.MaterialPalette.transparent
              : randomColor();
        },
        fillPatternFn: (_, index) {
          // 第 5 根柱子虚线填充
          return index == 4
              ? charts.FillPatternType.forwardHatch
              : charts.FillPatternType.solid;
        },
        dashPatternFn: (model, index) {
          return [1, 2];
        },
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      makeSeriesListData(),
      animate: true,
      defaultRenderer: charts.BarRendererConfig(
        // 柱子的外边框宽度，默认 0
        // 这里定义为 2，是为了测试有一根柱子设置了填充色（fillColor） 为透明。
        strokeWidthPx: 2,
      ),
    );
  }
}

class BarChartExample4 extends StatelessWidget {
  const BarChartExample4({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    // seriesCategory 属性用于设置当 barGroupingType 为 groupedStacked 时决定哪几个 series 是按照同一类堆叠。
    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Desktop A',
        seriesCategory: 'A',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        data: generateRandomSalesData(4),
      ),
      charts.Series(
        id: 'Desktop B',
        seriesCategory: 'B',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        data: generateRandomSalesData(4),
      ),
      charts.Series(
        id: 'Mobile A',
        seriesCategory: 'A',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        data: generateRandomSalesData(4),
      ),
      charts.Series(
        id: 'Mobile B',
        seriesCategory: 'B',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        data: generateRandomSalesData(4),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      makeSeriesListData(),
      animate: false,
      // 将多组 series 数据堆叠在一起，默认是 grouped
      // stacked 和 groupedStacked 的区别在于：groupedStacked 会根据 Series 的 seriesCategory 属性相同的堆叠在一起，不同的按 grouped 显示，本例每个数据点会显示两根柱子，其中每根柱子都堆叠了 2 个 bar。
      barGroupingType: charts.BarGroupingType.stacked,
      // 也可以在 defaultRenderer 中设置 groupingType 让图表堆叠显示
      // 如果同时指定了，则 defaultRenderer 里定义的优先级更高。
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.groupedStacked,
        // 控制堆叠的 bar 之间的间隙，默认 1
        stackedBarPaddingPx: 0,
        // 控制柱子的最大宽度（即最大能有多粗），minBarLengthPx 指定最小宽度
        maxBarWidthPx: 20,
        // 设置分组的权重为 3：2，即：第一组要比第二组柱子宽一些
        weightPattern: [3, 2],
        // By default, bar renderer will draw rounded bars with a constant
        // radius of 100.
        // To not have any rounded corners, use [NoCornerStrategy]
        // 默认柱子的圆角半径为 2，要想自定义柱子的圆角，请使用 ConstCornerStrategy
        // 要想没有圆角，使用 NoCornerStrategy 等效于 ConstCornerStrategy(0)。
        cornerStrategy: const charts.ConstCornerStrategy(4),
      ),
    );
  }
}

class BarChartExample5 extends StatelessWidget {
  const BarChartExample5({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Sales',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        // 控制如何显示 bar 的标签文本
        labelAccessorFn: (model, _) => '\$${model.sales.toString()}',
        // 控制显示在外部的标签样式。
        // 控制“内部显示标签样式”请指定 insideLabelStyleAccessorFn。
        // 下面是指定仅在年份为 2004 时标签显示为红色，其他柱子上的标签为灰色。
        outsideLabelStyleAccessorFn: (OrdinalSales sales, _) {
          final color = (sales.year == '2004')
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.gray.shadeDefault.darker;
          return charts.TextStyleSpec(color: color, fontSize: 10);
        },
        data: generateRandomSalesData(6),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      makeSeriesListData(),
      animate: true,
      barRendererDecorator: charts.BarLabelDecorator<String>(
        // 控制标签显示的位置，默认是 auto
        // 这里指定标签要显示在 bar 的外面
        labelPosition: charts.BarLabelPosition.outside,
      ),
      // domainAxis:   charts.OrdinalAxisSpec(),
    );
  }
}

// https://google.github.io/charts/flutter/example/bar_charts/spark_bar
class BarChartExample6 extends StatelessWidget {
  const BarChartExample6({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Sales',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        data: generateRandomSalesData(6),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      makeSeriesListData(),
      animate: true,
      // 自定义 measure 轴显示样式
      // measure 轴是一个数字轴，所以使用 NumericAxisSpec
      // NoneRenderSpec 表示不显示主轴数据点名称（但是 measure 轴线还是显示）
      primaryMeasureAxis: const charts.NumericAxisSpec(
        // 甚至轴线都不要显示
        showAxisLine: false,
        renderSpec: charts.NoneRenderSpec(),
      ),
      // domain 轴是一个序数轴，所以使用 OrdinalAxisSpec
      domainAxis: const charts.OrdinalAxisSpec(
        // 轴线要显示
        showAxisLine: true,
        // 但是不想在轴线以下把 domain 序数给显示出来
        renderSpec: charts.NoneRenderSpec(),
      ),
      // With a spark chart we likely don't want large chart margins.
      // 1px is the smallest we can make each margin.
      // 我们不希望有很大的图边距，所以都设置为 0
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
    );
  }
}

class PieChart1 extends StatelessWidget {
  const PieChart1({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    int n = 4;
    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Sales',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        // 控制标签显示内容
        labelAccessorFn: (model, _) => '${model.year} (${model.sales})',
        // 控制每块饼的颜色
        colorFn: (_, index) {
          return charts.MaterialPalette.cyan.makeShades(n)[index!];
        },
        data: generateRandomSalesData(n),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      makeSeriesListData(),
      animate: true,
      defaultRenderer: charts.ArcRendererConfig(
        // 设置弧度的宽度，即：外半径 - 内半径
        // 图表会在中间留下一个洞，像个甜甜圈。
        arcWidth: 100,
        // 设置圆弧的装饰器。
        // 如果我们要想显示标签，则需要定义这个装饰器。
        arcRendererDecorators: [
          // 使用一个 ArcLabelDecorator 装饰器来显示 label
          charts.ArcLabelDecorator<Object>(
            // 标签的位置，默认 auto
            labelPosition: charts.ArcLabelPosition.auto,
            // 控制外部标签的显示规范
            outsideLabelStyleSpec: charts.TextStyleSpec(
              color: charts.MaterialPalette.red.shadeDefault,
              // NOTE: fontSize 一定要指定，不然会报错：
              // The following _CastError was thrown during paint():
              // Null check operator used on a null value
              fontSize: 14,
            ),
            // 控制内部标签的显示规范
            // insideLabelStyleSpec: charts.TextStyleSpec(...),
          ),
        ],
      ),
    );
  }
}

class PieChart2 extends StatelessWidget {
  const PieChart2({Key? key}) : super(key: key);

  List<charts.Series<OrdinalSales, String>> makeSeriesListData() {
    int n = 4;
    return <charts.Series<OrdinalSales, String>>[
      charts.Series(
        id: 'Sales',
        domainFn: (model, _) => model.year,
        measureFn: (model, _) => model.sales,
        // 控制标签显示内容
        labelAccessorFn: (model, _) => '${model.year} (${model.sales})',
        // 自行定义每一块饼的颜色
        colorFn: (model, index) {
          switch (index) {
            case 0:
              return charts.ColorUtil.fromDartColor(Colors.green);
            case 1:
              return charts.ColorUtil.fromDartColor(Colors.deepOrange);
            case 2:
              return charts.ColorUtil.fromDartColor(Colors.lightBlue);
            case 3:
              return charts.ColorUtil.fromDartColor(Colors.blue);
            default:
              return charts.ColorUtil.fromDartColor(Colors.cyan);
          }
        },
        data: generateRandomSalesData(n),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      makeSeriesListData(),
      animate: true,
      defaultRenderer: charts.ArcRendererConfig(
        // 设置弧度的宽度，即：外半径 - 内半径
        // 图表会在中间留下一个洞，像个甜甜圈。
        arcWidth: 100,
        // 起始角度（以弧度为单位），顺时针方向。
        startAngle: 4 / 5 * pi,
        // 弧度的长度，默认为 2π表示 360 即整个圆，
        // 如果要绘制像仪表盘一样的饼图，可以结合 startAngle 和 arcLength 设置
        arcLength: 7 / 5 * pi,
        arcRendererDecorators: [
          charts.ArcLabelDecorator<Object>(
            labelPosition: charts.ArcLabelPosition.auto,
            // 是否要显示“外围标签”的引导线（指引线）
            showLeaderLines: false,
          ),
        ],
      ),
    );
  }
}
