import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/389e31d03d36465d8acd9939784df6f0.jpg!sswm';
    // final image = Image.network(imageUrl, fit: BoxFit.cover);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 正常图片
            Image.network(imageUrl, fit: BoxFit.cover),
            const SizedBox(height: 10),
            // 超出的部分会被裁剪
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(height: 100, child: Image.network(imageUrl)),
            ),
            const SizedBox(height: 10),
            // 裁剪为圆角图片, 但由于图片大小没限制，此处会占满屏幕宽度
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            // 图片限制大小和 fit 模式
            SizedBox(
              width: 150,
              height: 150,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            // 在指定的区域内裁剪图片
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            // 裁剪椭圆形
            // 如果 child 为正方形，则裁剪为圆形；如果 child 为矩形，则裁剪为椭圆形
            // 此处裁剪结果为圆形
            ClipOval(
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            // 此处裁剪结果为椭圆形
            ClipOval(
              child: SizedBox(
                width: 150,
                height: 100,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            // 此处裁剪结果为椭圆形
            ClipOval(
              child: Container(
                width: 100,
                height: 150,
                color: Colors.amber,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
    );
  }
}
