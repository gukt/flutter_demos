import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('List.of(...)', () {
    // List.of 接受一个 iterable 对象，和一个名称参数 growable（默认值为 true）
    // 如果 growable 为 true 表示该列表是可变的，反之为固定大小
    var numbers1 = List.of({1, 2, 3});
    // 对于可变长的列表，可以通过 add、remove 等方法新增或移除集合元素。
    numbers1.add(4);
    numbers1.removeAt(0);
    expect(numbers1, [2, 3, 4]);

    // 通过设定 growable = false 来初始化一个定长 List
    var numbers2 = List.of(numbers1, growable: false);
    // 定长列表调用 add, remove, addAll 等操作都会抛出 UnsupportedError
    expect(() => numbers2.add(5), throwsUnsupportedError);
  });

  test('List.empty()', () {
    // 初始化一个空的列表，empty 也可以指定 growable 命名参数，用来表示该列表是否可变长
    // 对于 growable = true，则等效于 <E>[];
    var emptyList = List.empty();
    expect(emptyList, isNotNull);
    expect(emptyList, isEmpty);
    // 类型断言，empty 构造函数不能指定具体的类型，所以列表元素类型为 dynamic
    // isA Matcher 用来匹配类型是不是指定的类型<T>
    expect(emptyList, isA<List<dynamic>>());
    // 定长 list 不能添加或移除元素
    expect(() => emptyList.add(3), throwsUnsupportedError);
  });

  test('List.empty, [], <E>[]', () {
    // 可以通过字面量 [] 来创建一个空列表，或带初始化值的，这种方式创建的列表是可变长的
    // 也可以通过 <E>[...] 指定列表元素类型，如果不指定类型，则列表元素是 dynamic 的，
    // 这种情况下可以往列表中添加任何类型的元素，包括 null
    var list1 = [];
    list1.add(1);
    list1.add(null);
    list1.add('hello');
    expect(list1, isA<List<dynamic>>());
    expect(list1.length, 3);

    // 初始化一个可变长空列表，列表元素类型为 int
    var list2 = <int>[];
    list2.add(1);
    // 因为指定了列表元素类型，所以当添加一个类型不匹配的元素时，编译器会提前报错：
    // The argument type 'String' can't be assigned to the parameter type 'int'.
    // listB.add('2');
    expect(list2, isA<List<int>>());

    // 如果初始化列表过程中指定了多个元素，则可以推断出列表元素类型
    // 因此 list3 的类型被推断为 List<int>
    var list3 = [1, 2];
    expect(list3, isA<List<int>>());

    // 当然了，我们可以显示指定变量类型，这样就不用指定 <E>[] 中的类型 E 了
    List<int> list4 = [];
    expect(list4, isA<List<int>>());
    // 如果显示指定变量类型，则 [...] 中初始化的元素必须和指定的元素类型匹配
    // 下面这样就会抛出错误：
    // The element type 'String' can't be assigned to the list type 'int'.
    // List<int> list5 = ['a'];
  });

  test('List.filled(...)', () {
    // filled 可以指定列表的初始元素个数，并将初始值全部设置为指定的值（第二个参数）
    // 根据第二个参数，可以推断出列表元素类型
    // 该方法还可以接受一个 growable 参数，默认为 false
    var list1 = List.filled(2, 1, growable: true);
    expect(list1, [1, 1]);
    list1.add(2);
    expect(list1.last, 2);
  });

  test('List.generate(...)', () {
    // 生成指定长度（第一个参数）的列表，具体如何生成由指定的函数（第二个参数）决定
    // 下面生成一个有三个元素的列表，元素值为所在索引的平方
    var list1 = List.generate(3, (index) => pow(index, 2));
    expect(list1, [0, 1, 4]);
  });

  test('List.from(...)', () {
    // 创建一个列表，包含给定的元素（Iterable，第一个参数）
    var list1 = {1, 2, 3};
    var list2 = List.from(list1, growable: true);
    expect(list1, equals(list2));
  });

  test('List.copyRange(...)', () {
    var list1 = [0, 1, 2];
    var list2 = <dynamic>['h', 'e', 'l', 'l', 'o'];
    // 将 list1 指定区间 [0,3) 的元素拷贝到目标列表 list2中的索引 1 处
    List.copyRange(list2, 1, list1, 0, 3);
    expect(list2, ['h', 0, 1, 2, 'o']);

    var list3 = <dynamic>['a', 'b'];
    // 如果目标列表中没有足够的空间拷贝新的元素，则会抛出如下异常：
    // Invalid argument (target): Not big enough to hold 3 elements at position 1: Instance(length:2) of '_GrowableList'
    expect(() => List.copyRange(list3, 1, list1, 0, 3), throwsArgumentError);
  });

  test('List.unmodifiable(...)', () {
    // 创建一个包含指定元素的不可变列表

//
// The [Iterator] of [elements] provides the order of the elements.

// An unmodifiable list cannot have its length or elements changed. If the elements are themselves immutable, then the resulting list is also immutable.

    var list1 = List.unmodifiable([1, 2]);
    // 对于不可变列表，元素是不能被更改的，
    expect(() => list1[0] = 3, throwsUnsupportedError);
  });

  test('Assign element value by index', () {
    var list1 = <dynamic>['a', 'b'];
    list1[0] = 1;
    list1[1] = 2;
    expect(list1, [1, 2]);
    // threw RangeError:<RangeError (index): Invalid value: Not in inclusive range 0..1: 2>
    expect(() => list1[2] = 3, throwsRangeError);
  });

  test('List.insert(...)', () {
    List<int> list1 = [];
    list1.add(1);
    list1.add(2);
    // 在指定的索引位置处添加一个元素
    // 列表必须是可增长的，index 必须不能为负数，且不能大于 length
    list1.insert(0, 3);
    expect(list1, [3, 1, 2]);
    expect(list1.length, 3);
  });

  test('List.reversed getter', () {
    var list1 = [1, 2, 3];
    // reversed 属性返回倒序结果，类型为 Iterable<E>
    expect(list1.reversed, isA<Iterable<int>>());
  });

  test('List.iterator getter', () {
    var list1 = [1, 2, 3];
    Iterator<int> it = list1.iterator;
    // 如果有下一个元素，则 Iterator 的 moveNext 会返回 true，
    // 该元素可以通过 current 属性来获取到
    expect(it.moveNext(), true);
    expect(it.current, 1);
    expect(it.moveNext(), true);
    expect(it.current, 2);
    expect(it.moveNext(), true);
    expect(it.current, 3);
    // 已经移到最后了，所以下面再调用 moveNext() 返回 false
    expect(it.moveNext(), false);

    // 列表可以通过 iterator.moveNext() 和 iterator.current 遍历
    // 由于之前的代码将游标已经移到最后，所以这里要重新获取一下 Iterator 对象，否则接下来循环不会打印输出任何元素
    it = list1.iterator;
    while (it.moveNext()) {
      debugPrint('${it.current}');
    }
  });

  test('List.first and last getter', () {
    var list1 = [1, 2, 3];
    expect(list1.first, 1);
    expect(list1.last, 3);

    var list2 = [];
    // 对于一个空列表，调用 first，last 都会抛出异常
    // first 和 last 内部是通过 List.iterator 移动游标实现的
    // last 就是一个 do...while 循环，从第一个元素一直移动到最后一个元素并返回
    expect(() => list2.first, throwsStateError);
    expect(() => list2.last, throwsStateError);
  });

  test('List.add(...) addAll(...), length setter', () {
    var list1 = [];
    // 对于可变列表，可以通过 add、addAll 来添加新元素
    list1.add(1);
    list1.add(null);
    list1.add('hello');
    list1.addAll({4, 'world'});

    // 还有一种特例可以添加元素，就是将 length 设置为一个更大的值，
    // 不过length 添加的新元素为 nul，因此，列表元素必须是可空的
    // 详细请见关于 length 的测试部分。
    var list2 = <int?>[1, 2];
    list2.length = 3;
    expect(list2, [1, 2, null]);
  });

  test('skip, skipWhile, take, takeWhile', () {
    // skip, skipWhile,
    // ================
    // skip 跳过指定个数的元素，取后面的所有元素
    var list1 = [1, 2, 3];
    var iterable1 = list1.skip(1);
    expect(iterable1, [2, 3]);
    expect(list1.skip(2), [3]);

    // skipWhile
    // 使用 test 从第一个元素开始测试，**找到第一个不符合的，返回后面的值**
    list1 = [1, 2, 3];
    iterable1 = list1.skipWhile((x) => x >= 2);
    expect(iterable1, [1, 2, 3]);
    // 从第一个元素开始测试，如果 < 2 则跳过，直到找到第一个不满足条件的，返回那个元素及后面的所有元素
    expect(list1.skipWhile((x) => x < 2), [2, 3]);

    // take, takeWhile
    list1 = [1, 2, 3];
    // 返回一个懒加载的可迭代（iterable）对象，返回对象元素个数可能会少于指定的 n
    // 读取元素要通过 iterator 来遍历，
    // count 参数不能为负数
    expect(list1.take(2), [1, 2]);
    expect(list1.take(100), [1, 2, 3]);

    // 从列表第一个元素开始，使用 test 进行测试，当测试条件返回 false 时就停止。
    list1 = <int>[1, 2, 3];
    iterable1 = list1.takeWhile((x) => x >= 2);
    // 第一个元素就不满足，所以 iterable 一个元素都不包含
    expect(iterable1, []);

    list1 = <int>[1, 2, 3, 5, 6, 7];
    expect(list1.takeWhile((x) => x < 5), [1, 2, 3]);
    expect(list1.takeWhile((x) => x != 3), [1, 2]);
    expect(list1.takeWhile((x) => x != 4), [1, 2, 3, 5, 6, 7]);
    expect(list1.takeWhile((x) => x.isOdd), [1]);

// skip/skipWhile 经常和 take/takeWhile 联用，
// 可实现按条件跳过某些元素后再按取符合条件的子列表
    list1 = <int>[1, 2, 3, 5, 6, 7];
    // 跳过第一个元素
    iterable1 = list1.skipWhile((x) => x < 2);
    // 从第二个元素开始测试，直到 test 返回 false 就停止
    // NOTE: 千万别忘了这里再赋值给 iterable1
    iterable1 = iterable1.takeWhile((x) => x <= 5);
    expect(iterable1, [2, 3, 5]);
  });

  test('description', () {
    var list1 = [1, 2, 3];
    // 测试只要有任何一个元素满足测试条件，就返回 true
    expect(list1.any((element) => element < 2), true);
    // 测试列表中的每一个元素都满足测试条件，如果都满足则返回 true，反之 false
    expect(list1.every((element) => element > 0), true);

    // join 方法使用指定的分隔符连接各个元素，返回 String
    expect([1, 2, 3].join(','), '1,2,3');

    // clear 清空列表
    list1 = [1, 2, 3];
    list1.clear();
    expect(list1, isEmpty);

    // contains
    var list2 = <int?>[1, 2, 3, null];
    expect(list2.contains(1), true);
    expect(list2.contains(4), false);
    expect(list2.contains(null), true);

    // single
    // 检查列表是否只有一个元素，如果是，返回那个元素，否则抛出 StateError
    expect(() => [1, 2].single, throwsStateError);
    expect(() => [].single, throwsStateError);

    // list1.asMap();
    // list1.cast();
    // list1.elementAt(index);
    // list1.expand((element) => null);
    // list1.fillRange(start, end);
    // list1.firstWhere((element) => false);
    // list1.fold(initialValue, (previousValue, element) => null);
    // list1.followedBy(other);
    // list1.forEach((element) {});
    // list1.getRange(start, end);
    // list1.indexOf(element);
    // list1.indexWhere((element) => false);
    // list1.lastIndexOf(element);
    // list1.lastIndexWhere((element) => false);
    // list1.insert(index, element);
    // list1.insertAll(index, iterable);
    // list1.lastWhere((element) => false);

    // list1.map((e) => null);
    // list1.reduce((value, element) => null);

    // list1.getRange(start, end);
    // list1.setRange(start, end, iterable);
    // list1.fillRange(start, end)
    //  list1.removeRange(start, end);
    // list1.replaceRange(start, end, replacements);

    // list1.setAll(index, iterable);
    // list1.shuffle();

    // list1.where((element) => false);
    // list1.whereType();
    // list1.lastWhere((element) => false);
    // list1.firstWhere((element) => false);
    // list1.indexWhere((element) => false);
    // list1.removeWhere((element) => false);
    // list1.retainWhere((element) => false);
    // list1.singleWhere((element) => false);
    //  list1.lastIndexWhere((element) => false);

    //  list1.sort();
    //  list1.sublist(start);

    //  list1.toList();
    //  list1.toSet();
  });

  test('Read and assign the length property', () {
    var list1 = [1, 2, 3];
    //  通过设定 length 长度，可以增加或减少列表元素个数
    list1.length = 0;
    expect(list1, []);

    // 由于 list1 元素不能为 null，所以这里通过设定 length 往列表中添加 null 元素会报 TypeError
    expect(() => list1.length = 3, throwsA(isA<TypeError>()));

    var list2 = <int?>[1, 2];
    // // 因为 list2 元素是可以为 null 的，所以这里可以通过设置 length 来扩充列表
    list2.length = 3;
    expect(list2, [1, 2, null]);
  });

  test(
      'Remove elements with remove, removeAt, removeRange, removeLast, removeWhere methods',
      () {
    var list1 = [1, 2, 3, 1];

    // remove
    // ======
    // 从列表中删除第一次出现的元素
    list1 = [1, 2, 3, 1];
    list1.remove(1);
    expect(list1, [2, 3, 1]);

    // removeAt
    // ========
    // 移除指定索引处的元素
    // 该方法将会造成指定索引后的元素往前移动
    // 索引值必须在区间 [0, length) 内，列表必须是可变长的
    // 如果索引值超出范围，则会引发 throwsRangeError
    list1 = [1, 2, 3];
    list1.removeAt(0);
    expect(list1, [2, 3]);
    // 如果索引值超出范围，则会引发 throwsRangeError
    expect(() => list1.removeAt(-1), throwsRangeError);
    expect(() => list1.removeAt(100), throwsRangeError);

    // removeLast
    // ==========
    // 移除最后一个元素，列表必须是可变长且非空的
    // 如果在空列表上调用 removeLast，则会抛出 RangeError
    // 如果在定长列表上调用 removeLast，则会抛出 UnsupportedError
    expect(() => [].removeLast(), throwsRangeError);
    // 固定长度的列表是不可移除元素的
    expect(() => List.of([1, 2, 3], growable: false).removeLast(),
        throwsUnsupportedError);

    // 移除指定区间 start(inclusive), end(exclusive) 内的元素
    // 被移除的元素个数为 end - start
    // 参数值合法区间：0 ≤ start ≤ end ≤ length
    list1 = [1, 2, 3, 4];
    list1.removeRange(1, 2);
    expect(list1, [1, 3, 4]);

    // 给定一个测试条件，移除满足该测试条件的所有元素
    list1 = [1, 2, 3, 4, 1, 2, 1];
    // 把所有大于 1 的元素都移除掉
    list1.removeWhere((element) => element > 1);
    expect(list1, [1, 1, 1]);
  });
}
