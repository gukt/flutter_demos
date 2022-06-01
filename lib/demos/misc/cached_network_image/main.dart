import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

/// 各种免费图片资源：
/// https://www.pexels.com/zh-cn/search/animal/
///
///
void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://images.pexels.com/photos/1661179/pexels-photo-1661179.jpeg?cs=srgb&dl=pexels-roshan-kamath-1661179.jpg&fm=jpg';
    const gifUrl =
        'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif';
    return Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            // 显示一张来自网络的图
            Image.network(imageUrl),

            // Image widget 令人兴奋的特性之一：提供了开箱即用的 gif 动画支持
            Image.network(
              gifUrl,
              loadingBuilder: (context, child, loadingProgress) {
                return Text(
                    '${loadingProgress?.expectedTotalBytes}/ ${loadingProgress?.expectedTotalBytes}');
                int bytesLoaded = loadingProgress?.expectedTotalBytes ?? 0;
                int bytesTotal = loadingProgress?.expectedTotalBytes ?? 0;
                String percent =
                    (bytesLoaded * 100 / bytesTotal.clamp(1, double.infinity))
                        .toStringAsFixed(2);
                return Text('$bytesLoaded/$bytesTotal ($percent %)');
              },
            ),

            // 这里用到了透明图像，透明图形是从 Flutter 包里提取出来的，只有一个公共变量
            // 代码在这里：https://github.com/brianegan/transparent_image/blob/master/lib/transparent_image.dart，其实只是一个变量定义返回 Uint8List
            // Package: https://pub.flutter-io.cn/packages/transparent_image
            //
            // 显示一个透明图形
            Image.memory(
              kTransparentImage,
              width: 50,
              height: 50,
            ),

            // FadeInImage 提供两个命名构造函数 memoryNetwork 和 assetNetwork
            // 前缀 memory* 和 asset* 指示占位符从哪里来，看下面的两个例子
            //
            // 从网络上加载图片并渐入显示，占位符从内存加载
            FadeInImage.memoryNetwork(
              // 从内存加载占位符
              placeholder: kTransparentImage,
              // 网络图片地址
              image: imageUrl,
            ),

            // 从网络上加载图片并渐入显示，占位符从本地存储加载
            FadeInImage.assetNetwork(
              // 设定占满屏幕宽度
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              // 指定位于本地 assets 中的占位符图片地址
              placeholder: 'assets/images/loading.gif',
              // 由于 loading 比较小，要保持原有大小，放大就难看了
              placeholderFit: BoxFit.scaleDown,
              image: imageUrl,
            ),

            // 缓存从网络下载的图片用于离线显示是十分方便的，
            // 你需要引入 cached_network_image 这个 package 来实现这项功能。
            CachedNetworkImage(
              // 除了缓存，cached_image_network 包也支持占位符和加载后的图片淡入
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: imageUrl,
              // 出错时显示的 Widget
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),

            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Colors.red,
                      BlendMode.colorBurn,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}
