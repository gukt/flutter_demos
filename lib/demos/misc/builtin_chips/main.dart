import 'package:flutter/material.dart';

/// Material Design 有 4 种 Chip 类型：
/// -
///
/// TODO: ChipThemeData
/// See also:
/// - https://material.io/components/chips
void main() => runApp(const MaterialApp(home: Scaffold(body: Home())));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewMode = 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Chip')),
      body: Column(
        children: [
          const _FilterChipExample(),
          const _InputChipExample1(),
          const _InputChipExample2(),
          const _ChoiceChipExample(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ChoiceChip: '),
              Wrap(
                spacing: 6,
                children: [
                  ChoiceChip(
                    label: const Text('苹果'),
                    selected: true,
                    selectedColor: Colors.grey.shade300,
                  ),
                  const ChoiceChip(label: Text('香蕉'), selected: false),
                  const ChoiceChip(label: Text('西瓜'), selected: false),
                ],
              )
            ],
          ),
          const Example1(),
          IconTheme(
            data: const IconThemeData(size: 22),
            child: Wrap(
              spacing: 6,
              children: [
                const Chip(
                  avatar: Icon(Icons.check),
                  label: Text('启用'),
                ),
                const Chip(
                  avatar: Icon(Icons.check_circle),
                  label: Text('启用'),
                ),
                const Chip(
                  avatar: Icon(Icons.check_circle),
                  label: Text('启用'),
                ),
                const Chip(
                  avatar: Icon(Icons.favorite_border),
                  label: Text('喜欢'),
                ),
                const Chip(
                  avatar: Icon(Icons.thumb_up_off_alt),
                  label: Text('赞'),
                ),
                const Chip(
                  avatar: Icon(Icons.thumb_up),
                  label: Text('赞'),
                ),
                const Chip(
                  avatar: Icon(Icons.thumb_down_off_alt),
                  label: Text('反对'),
                ),
                const Chip(
                  avatar: Icon(Icons.thumb_down),
                  label: Text('反对'),
                ),
                const Chip(
                  avatar: Icon(Icons.bookmark_border),
                  label: Text('收藏'),
                ),
                const Chip(
                  avatar: Icon(Icons.bookmark),
                  label: Text('收藏'),
                ),
                const Chip(
                  avatar: Icon(Icons.search),
                  label: Text('搜索'),
                ),
                const Chip(
                  avatar: Icon(Icons.view_comfy_alt_sharp),
                  label: Text('查看案例'),
                ),
                const Chip(
                  avatar: Icon(Icons.get_app),
                  label: Text('下载'),
                ),
                const Chip(
                  avatar: Icon(Icons.view_module),
                  label: Text('网格'),
                ),
                const Chip(
                  avatar: Icon(Icons.view_list),
                  label: Text('列表'),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return ActionChip(
                    avatar: Icon(
                        viewMode == 0 ? Icons.view_module : Icons.view_list),
                    label: const Text('网格'),
                    onPressed: () {
                      setState(
                        () => viewMode = viewMode == 0 ? 1 : 0,
                      );
                    },
                  );
                }),
                const Chip(
                  avatar: Icon(Icons.check),
                  label: Text('启用'),
                ),
                const ChoiceChip(
                  label: Text('上海'),
                  selected: true,
                ),
                const ChoiceChip(
                  label: Text('北京'),
                  selected: false,
                ),
                const ChoiceChip(
                  label: Text('广州'),
                  selected: false,
                ),
                const ChoiceChip(
                  label: Text('深圳'),
                  selected: false,
                ),
                // Create a chip that acts like a checkbox.

// The [selected], [label], [autofocus], and [clipBehavior] arguments must not be null. The [pressElevation] and [elevation] must be null or non-negative. Typically, [pressElevation] is greater than [elevation].

                // FilterChip, 类似于 CheckBox
                // 当 selected 属性为 true 时，前面显示一个“小对勾”图标
                // 他可以设置 autofocus 自动聚焦
                FilterChip(
                  label: const Text('FilterChip (Selected)'),
                  selected: true,
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('FilterChip'),
                  selected: false,
                  onSelected: (bool value) {},
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: const Text('Z'),
                  ),
                  label: const Text('张三'),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: const Text('L'),
                  ),
                  label: const Text('李四'),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: const Text('W'),
                  ),
                  label: const Text('王二麻子'),
                ),
              ],
            ),
          ),
          Chip(
            label: const Text('香蕉'),
            // 左侧图标组件
            // avatar: Icon(Icons.calendar_month),
            // // 右侧删除按钮，默认为 Icons.cancel，只有提供了 onDeleted 才会显示这个按钮
            deleteIcon: const Icon(Icons.clear, size: 18),
            deleteButtonTooltipMessage: '点击删除',
            onDeleted: () {},
          ),
          Chip(
            label: const Text('苹果'),
            // 左侧图标组件
            // avatar: Icon(Icons.calendar_month),
            // // 右侧删除按钮，默认为 Icons.cancel，只有提供了 onDeleted 才会显示这个按钮
            deleteIcon: const Icon(Icons.clear, size: 18),
            deleteButtonTooltipMessage: '点击删除',
            onDeleted: () {},
          ),
          Chip(
            label: const Text('哈密瓜'),
            // 左侧图标组件
            // avatar: Icon(Icons.calendar_month),
            // // 右侧删除按钮，默认为 Icons.cancel，只有提供了 onDeleted 才会显示这个按钮
            deleteIcon: const Icon(Icons.clear, size: 18),
            deleteButtonTooltipMessage: '点击删除',
            onDeleted: () {},
          ),
          const Chip(
            label: Text('Assist'),
            avatar: const Icon(Icons.calendar_month),
          ),
          const Chip(
            label: Text('Assist'),
            avatar: const Icon(Icons.calendar_month),
          ),
          const Chip(
            label: Text('Assist'),
            avatar: Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}

class Example1 extends StatelessWidget {
  const Example1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: const Text('2022-06-01'),
      // 左侧图标组件
      avatar: const Icon(Icons.calendar_month),
      // // 右侧删除按钮，默认为 Icons.cancel
      deleteIcon: const Icon(Icons.clear, size: 18),
      deleteButtonTooltipMessage: '点击删除',
      // 只有提供了 onDeleted 才会显示 deleteIcon 指定的按钮
      onDeleted: () {},
    );
  }
}

class _FilterChipExample extends StatefulWidget {
  const _FilterChipExample({Key? key}) : super(key: key);

  @override
  State<_FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<_FilterChipExample> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        // FilterChip, 类似于 CheckBox
        // 当 selected 属性为 true 时，前面显示一个“小对勾”图标
        // 他可以设置 autofocus 自动聚焦
        // 点击
        FilterChip(
          label: const Text('启用'),
          selected: selected,
          // 设置相对于父级的高度（Chip 下的阴影），默认 0
          elevation: 6,
          // 按下时，相对于父级的高度，默认 8，典型情况下，pressElevation 要设置的比 elevation 大（但不是必须的，只是这种情况看起来效果不好，不符合 Material Design 规范）
          // NOTE: 如果 evelation 设置了值，但 pressElevation 没有设置，则 pressElevation 取和 evelation 相同的值。
          pressElevation: 12,
          // 他可以设置 autofocus 自动聚焦
          // 理想情况下，每个[FocusScope]中只有一个小部件设置了自动焦点。
          // 如果有多个小部件设置了自动焦点，那么添加到树中的第一个小部件将获得焦点。
          // 不能为空。 默认值为false。
          autofocus: true,
          // 选择状态下的背景色
          selectedColor: null,
          // 未启用状态下的背景色
          disabledColor: null,
          // 设置“未启用”和“选择”状态下 ChoiceChip 的背景颜色
          // 默认为 Colors.grey
          backgroundColor: null,
          // 按住 label 或 avatar 时显示的提示文本
          tooltip: '这是 ChoiceChip, 类似 Checkbox 效果',
          // 设置外形，如果指定为 null，则默认足球场（药丸）形状
          shape: null,
          // 设置边框的颜色和 weight，如果为 null，则使用 shape 设置的边框
          side: null,
          // 是否显示复选标记，默认 true
          showCheckmark: true,
          // 复选标记的颜色
          checkmarkColor: Colors.black,
          // label 样式，默认为 [TextTheme.bodyText1]
          labelStyle: null,
          // 围绕 label 的边距，默认 start，end 为 4 个像素，top，bottom 为 0 像素
          labelPadding: null,
          // 当 elevation 大于 0 时，显示的阴影颜色，默认 Colors.black
          shadowColor: Colors.grey,
          // 当选中状态时且 elevation 大于 0 时，显示的阴影颜色，默认也是 Colors.black
          selectedShadowColor: Colors.blue,
          // 内容和外部边框之间的填充，当设置为 null 时，默认内容距离四条边框都为 4.
          // 结合 labelPadding，默认情况下，label 距离右边框为 6 像素。
          padding: null,
          // 设置视觉密度
          // https://material.io/design/layout/applying-density.html
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // VisualDensity? visualDensity,
          // MaterialTapTargetSize? materialTapTargetSize,
          // 在选中/未选中状态切换时调用
          // 当状态发生变化时，value 为新的状态值，但实际上 FilterChip 并不会改变任何状态，直到父级重新 build 时才会发生改变
          onSelected: (bool value) {
            setState(() => selected = !selected);
          },
        ),
        FilterChip(
          label: const Text('锁定'),
          selected: selected,
          // label 前面的头像 widget，在 FilterChip 中一般不设置改值，因为当选中状态时，这个 Widget 并不会小时，而是将“小对勾”显示在这个 avatar 上面，叠起来了。
          avatar: Icon(
            Icons.lock,
            size: 16,
            // 当选中状态是这里设置为透明颜色
            color: selected ? Colors.transparent : Colors.grey,
          ),
          // 当 selected = true 时，在 avatar 上绘制的半透明高亮部分的形状
          // 默认为 CircleBorder
          avatarBorder: const StadiumBorder(),
          onSelected: (value) {
            setState(() => selected = !selected);
          },
        ),
        FilterChip(
          label: const Text('锁定'),
          avatar: Icon(
            Icons.lock,
            size: 36,
            // 当选中状态是这里设置为透明颜色
            color: selected ? Colors.transparent : Colors.grey,
          ),
          // 设置裁剪行为，只有当子组件超出父组件范围时，才有 clip 的概念。
          // 默认为 Clip.none, 表示超出也不裁剪
          // none：不裁剪，系统默认值，如果子组件不超出边界，此值没有任何性能消耗。
          // hardEdge：裁剪但不应用抗锯齿，速度比none慢一点，但比其他方式快。
          // antiAlias：裁剪而且抗锯齿，此方式看起来更平滑，比antiAliasWithSaveLayer快，比hardEdge慢，通常用于处理圆形和弧形裁剪。
          // antiAliasWithSaveLayer：裁剪、抗锯齿而且有一个缓冲区，此方式很慢，用到的情况比较少。
          // 本例中故意将 avatar 的 Icon 设置很大，看看裁剪和不裁剪的效果
          // 注释下行，看不裁剪效果
          clipBehavior: Clip.antiAlias,
          selected: selected,
          onSelected: (value) {
            setState(() => selected = !selected);
          },
        ),
      ],
    );
  }
}

class _InputChipExample1 extends StatefulWidget {
  const _InputChipExample1({Key? key}) : super(key: key);

  @override
  State<_InputChipExample1> createState() => _InputChipExample1State();
}

class _InputChipExample1State extends State<_InputChipExample1> {
  final channels = ['语文', '数学', '物理', '化学', '体育'];

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 6, children: [
      ...channels.map((e) => InputChip(
            label: Text(e),
            deleteIcon: const Icon(Icons.clear, size: 16),
            onDeleted: () {
              setState(() => channels.remove(e));
            },
          ))
    ]);
  }
}

class _InputChipExample2 extends StatefulWidget {
  const _InputChipExample2({Key? key}) : super(key: key);

  @override
  State<_InputChipExample2> createState() => _InputChipExample2State();
}

class _InputChipExample2State extends State<_InputChipExample2> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 6, children: [
      // InputChip 也能实现和 FilterChip 实现完全一样的效果
      // InputChip 比 FilterChip 多一个 onPressed 和 onDeleted
      // 因此，它比 FilterChip 功能更丰富一些
      // 其他通用属性，请参考本文件的 [_FilterExample]
      InputChip(
        label: const Text('艺术'),
        selected: selected,
        // 不用 onSelected 也可以是想选中状态的切换效果
        // NOTE: onSelected 和 onPressed 不能同时指定
        onPressed: () {
          setState(() => selected = !selected);
        },
      ),
      InputChip(
        label: const Text('人文'),
        // 和 FilterChip 一样，只要这里设置为 true，则前面会显示一个“小对勾”图标。
        selected: selected,
        // 当选中状态发生切换时调用
        // NOTE:
        // 1. 实际上，如果 selected 设置为常量 true, 每次点击虽然 selected 值没发生变化，但 onSelected 也会一只被调用。
        // 2. onSelected 和 onPressed 不能同时指定
        onSelected: (value) {
          setState(() => selected = !selected);
          debugPrint('value: $value');
        },
      ),
      InputChip(
        label: const Text('管理'),
        // 使用启用输入, 默认 true
        isEnabled: false,
        // 如果 isEnabled 为 false，则这里虽然设置的 onPressed 也会被禁用
        onPressed: () => debugPrint('onPressed'),
      ),
    ]);
  }
}

class _ChoiceChipExample extends StatelessWidget {
  const _ChoiceChipExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: const [
        Chip(
          label: Text('Chip'),
        ),
        RawChip(
          label: Text('RawChip'),
        ),
      ],
    );
  }
}
