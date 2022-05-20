import 'package:flutter/material.dart';

/// See also:
/// - [创建一个可拖放的 UI 组件](https://flutter.cn/docs/cookbook/effects/drag-a-widget)
void main() => runApp(const MaterialApp(home: Home()));

const List<Item> _items = [
  Item(
    name: 'Spinach Pizza',
    totalPriceCents: 1299,
    uid: '1',
    imageProvider: NetworkImage('https://flutter'
        '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg'),
  ),
  Item(
    name: 'Veggie Delight',
    totalPriceCents: 799,
    uid: '2',
    imageProvider: NetworkImage('https://flutter'
        '.dev/docs/cookbook/img-files/effects/split-check/Food2.jpg'),
  ),
  Item(
    name: 'Chicken Parmesan',
    totalPriceCents: 1499,
    uid: '3',
    imageProvider: NetworkImage('https://flutter'
        '.dev/docs/cookbook/img-files/effects/split-check/Food3.jpg'),
  ),
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final List<Customer> _people = [
    Customer(
      name: 'Makayla',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
    ),
    Customer(
      name: 'Nathan',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar2.jpg'),
    ),
    Customer(
      name: 'Emilio',
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar3.jpg'),
    ),
  ];

// 定义一个共享的 GlobalKey，用户拖动时显示的 Widget 都要用到它
  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnCustomerCart({
    required Item item,
    required Customer customer,
  }) {
    setState(() {
      customer.items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: _buildMenuList(),
          ),
          _buildPeopleRow(),
        ],
      ),
    );
  }

  // 构建菜单列表
  Widget _buildMenuList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12.0,
        );
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildMenuItem(
          item: item,
        );
      },
    );
  }

// 构建菜单列表项
  Widget _buildMenuItem({required Item item}) {
    // 将每一个菜单项包裹在 LongPressDraggable 里
    // 它可以识别用户何时发生了长按，然后在用户手指附近显示一个新的 Widget，且 Widget 位于用户手指下方的中心，当用户拖动时，这个新的 Widget 跟随用户的手指。
    // 当用户松开手指时，feedback 会自动消失
    return LongPressDraggable<Item>(
      // 被拖放到 DragTarget 上的数据
      data: item,
      // 设置拖动时显示的可拖动 Widget 的锚点策略，有两个内建的策略：
      // 1. childDragAnchorStrategy - 基于 child 位置
      // 默认策略，如果 feedback 和 child 尺寸相同，那么这意味着当拖动开始时，feedback 和 child 完全重叠，如果 feedback 和 child 尺寸不同，那么她倆的中心点会不重合，你可以通过 比如 FractionalTranslation 或 Transform.translation 对 feedback 内部的 child 进行平移。
      //
      // 2. pointerDragAnchorStrategy - 基于手指位置
      // 如果 feedback 和 child 尺寸相同，那么这意味着当拖动开始时，feedback 的左上角将在手指下方，此时feedback 和 child 不会重合，此时可借助 FractionalTranslation 对 feedback 进行平移调整。本例中 DraggingListItem 内部就是用 FractionalTranslation 包括了一层。
      dragAnchorStrategy: pointerDragAnchorStrategy,
      // feedback 表示长按时显示在用户手指下面的 Widget，而下面的 child 指定正常状态时显示的列表项
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoProvider: item.imageProvider,
      ),
      child: MenuListItem(
        name: item.name,
        price: item.formattedTotalItemPrice,
        photoProvider: item.imageProvider,
      ),
    );
  }

  Widget _buildPeopleRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 20.0,
      ),
      child: Row(
        children: _people.map(_buildPersonWithDropZone).toList(),
      ),
    );
  }

  Widget _buildPersonWithDropZone(Customer customer) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
        ),
        child: DragTarget<Item>(
          builder: (context, candidateItems, rejectedItems) {
            return CustomerCart(
              hasItems: customer.items.isNotEmpty,
              highlighted: candidateItems.isNotEmpty,
              customer: customer,
            );
          },
          // 当用户将可拖动对象放在 DragTarget 上时，DragTarget 可以接受或拒绝来自可拖动对象的数据。
          onAccept: (item) {
            _itemDroppedOnCustomerCart(
              item: item,
              customer: customer,
            );
          },
        ),
      ),
    );
  }
}

// 定义一个"顾客购物车“
class CustomerCart extends StatelessWidget {
  const CustomerCart({
    Key? key,
    required this.customer,
    this.highlighted = false,
    this.hasItems = false,
  }) : super(key: key);

  final Customer customer;
  // 是否高亮显示
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    // 高亮切换时，文本颜色是不一样的，因为高亮时背景色是红色，所以文本设为白色
    final textColor = highlighted ? Colors.white : Colors.black;
    // 高亮时要对 child 进行略微放大，所以用到了 Transform
    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8.0 : 4.0,
        borderRadius: BorderRadius.circular(22.0),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 用户头像
              ClipOval(
                child: SizedBox(
                  width: 46,
                  height: 46,
                  child: Image(
                    image: customer.imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              // 用户名称
              Text(
                customer.name,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: textColor,
                      fontWeight:
                          hasItems ? FontWeight.normal : FontWeight.bold,
                    ),
              ),
              // 控制可见性
              // 详细介绍请见：https://juejin.cn/post/6995727978034380808
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  children: [
                    const SizedBox(height: 4.0),
                    // 显示订单总价格
                    Text(
                      customer.formattedTotalItemPrice,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    // 显示已购商品个数
                    Text(
                      '${customer.items.length} item${customer.items.length != 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: textColor,
                            fontSize: 12.0,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 定义一个“菜单列表项” Widget，包含名称，价格和图片（ImageProvider）
class MenuListItem extends StatelessWidget {
  const MenuListItem({
    Key? key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  }) : super(key: key);

  final String name;
  final String price;
  final ImageProvider photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    // 创建一张材质
    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          // 横向尽可能的大
          mainAxisSize: MainAxisSize.max,
          children: [
            // 圆角矩形裁剪
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: isDepressed ? 115 : 120,
                    width: isDepressed ? 115 : 120,
                    child: Image(
                      image: photoProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: 18.0,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    price,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 正在拖动的列表项，也是一个无状态的 Widget
class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    Key? key,
    required this.dragKey,
    required this.photoProvider,
  }) : super(key: key);

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    // FractionalTranslation 和 Transform.translate 都是对 child 进行平移的
    // 不同的是 Transform.translate 使用参数 offset 指定具体的平移值
    // 而 FractionalTranslation 使用参数 translation 指定相对于 child 宽高的倍数
    // https://www.jianshu.com/p/b44767284d94?ivk_sa=1024320u
    return FractionalTranslation(
      // 将 child 水平向左平移宽度的一般，并且向上平移高度的一半
      // 因为本例中，我们显示在手指下面的可拖动的 Widget 的锚定策略（Anchor Strategy）为基于用户手指位置，意味着 DraggingListItem 的左上角坐标为用户手指位置，但我们希望该 DraggingListItem 的中心点在手指位置，所以要向左和向上移动宽高各一般的距离
      // 如果 LongPressDraggable 的 dragAnchorStrategy 属性设置为 childDragAnchorStrategy, 则一般不用偏移（实际上当 LongPressDraggable 指定的 child 和 feedback 大小相差不大时，feedback 和 child 的中心点只有一点点不重合，具体你可以思考为什么会这样？为了要严格重合，需要根据 feedback 和 child 的宽高计算差值然后除以 2）
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        // 每一个圆角图片 clip 都需要指定一个 dragKey
        key: dragKey,
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          // 原始图片宽高为 120，这里设定 150，表示拖动时显示在拖动点下面的图片有一点点放大
          // 这样看起来会比较明显，效果更酷一点
          height: 150,
          width: 150,
          // 拖动点下面显示的图片要设置一点点透明度
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image: photoProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  const Item({
    required this.totalPriceCents,
    required this.name,
    required this.uid,
    required this.imageProvider,
  });
  // 价格，单位：美分
  final int totalPriceCents;
  final String name;
  final String uid;
  final ImageProvider imageProvider;
  String get formattedTotalItemPrice =>
      '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
}

class Customer {
  Customer({
    required this.name,
    required this.imageProvider,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  final ImageProvider imageProvider;
  final List<Item> items;

  String get formattedTotalItemPrice {
    final totalPriceCents =
        items.fold<int>(0, (prev, item) => prev + item.totalPriceCents);
    return '\$${(totalPriceCents / 100.0).toStringAsFixed(2)}';
  }
}
