import 'package:flutter/material.dart';

// TODO http://events.jianshu.io/p/776575c4e03b 聊天气泡
void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://images.pexels.com/photos/1661179/pexels-photo-1661179.jpeg?cs=srgb&dl=pexels-roshan-kamath-1661179.jpg&fm=jpg';
    // final image = Image.network(imageUrl, fit: BoxFit.cover);

    return Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                color: Colors.deepOrangeAccent,
                height: 200.0,
              ),
            ),
            ClipPath(
              clipper: BottomWaveCurveClipper(),
              child: Container(
                color: Colors.deepOrangeAccent,
                height: 200.0,
              ),
            ),
            ClipPath(
              clipper: BottomSlashClipper(500, 200),
              child: Container(
                color: Colors.deepOrangeAccent,
                height: 200.0,
              ),
            ),
            // 正常图片
            Image.network(imageUrl, fit: BoxFit.cover),

            ClipPath(
              clipper: TriangleClipper(),
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            ClipRect(
              clipper: RectClipper1(),
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            ClipRRect(
              clipper: RectClipper2(),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),

            // ClipRect(
            //   child: Container(
            //     width: 150,
            //     height: 150,
            //     color: Colors.orange,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // 原点开始，花一条横线
    path.lineTo(size.width, 0.0);
    // 再画到中心点
    path.lineTo(size.width / 2, size.height);
    // 将起点和终点之间关闭（连起来）
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RectClipper1 extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(100, 10, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class RectClipper2 extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    return RRect.fromRectAndCorners(
      Rect.fromCenter(center: const Offset(100, 100), width: 200, height: 100),
      topLeft: const Radius.circular(50),
      bottomRight: const Radius.circular(50),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // 第1个点
    path.lineTo(0, 0);
    // 第2个点
    path.lineTo(0, size.height - 50.0);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEdnPoint = Offset(size.width, size.height - 50.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEdnPoint.dx, firstEdnPoint.dy);
    // 第3个点
    path.lineTo(size.width, size.height - 50.0);
    // 第4个点
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomWaveCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    //波浪曲线路径
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height - 40.0); //第2个点
    var firstControlPoint = Offset(size.width / 4, size.height); //第一段曲线控制点
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30); //第一段曲线结束点
    path.quadraticBezierTo(
        //形成曲线
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width / 4 * 3, size.height - 90); //第二段曲线控制点
    var secondEndPoint = Offset(size.width, size.height - 40); //第二段曲线结束点
    path.quadraticBezierTo(
        //形成曲线
        secondControlPoint.dx,
        secondControlPoint.dy,
        secondEndPoint.dx,
        secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomSlashClipper extends CustomClipper<Path> {
  BottomSlashClipper(this.width, this.height);

  final double width;
  final double height;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(width, 0.0);
    // path 斜线效果
    path.lineTo(width, height / 2);
    path.lineTo(0.0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
