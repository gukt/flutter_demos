import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            // 资源存放目录名称不是一定要是 assets, 它只是约定俗成
            // 所以每个图片具体路径钱还是要带上 assets/
            // lib 目录是固定的，所以不要在前面再加上 lib/
            const Image(image: AssetImage('assets/images/lake.jpeg')),
            const FlutterLogo(size: 16),
            const FlutterLogo(size: 32, style: FlutterLogoStyle.horizontal),
            const FlutterLogo(size: 32, style: FlutterLogoStyle.stacked),
            const FlutterLogo(size: 48, duration: Duration(seconds: 10)),

            // 加载网络图片
            const Image(
              image:
                  NetworkImage('https://placeimg.com/500/500/any', scale: 1.0),
            ),

            Image.network('https://placeimg.com/500/500/any')

            // TODO 带占位符的图片，如果加载失败，显示占位符
          ],
        ),
      ),
    );
  }
}
