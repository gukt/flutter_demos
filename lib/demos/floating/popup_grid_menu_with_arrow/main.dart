import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomPopup(
          child: Text('这是弹出层显示的主内容'),
        ),
      ),
    );
  }
}

class CustomPopup extends StatelessWidget {
  const CustomPopup({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: PhysicalShape(
        color: Colors.black87,
        elevation: 10,
        shadowColor: Colors.blueAccent,
        clipper: const Clipper1(10, 20),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.black87,
            child: GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              children: const [
                MenuItem(label: 'Home', icon: Icons.home),
                MenuItem(label: 'Copy', icon: Icons.copy),
                MenuItem(label: 'Mail', icon: Icons.mail),
                MenuItem(label: 'Settings', icon: Icons.settings),
                MenuItem(label: 'Menu', icon: Icons.menu),
                MenuItem.placeholder(),
                // MenuItem(label: 'Bug', icon: Icons.bug_report_sharp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key, this.label, this.icon}) : super(key: key);

  final String? label;
  final IconData? icon;

  const MenuItem.placeholder({Key? key})
      : this(key: key, label: null, icon: null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: label == null && icon == null
          ? const SizedBox.shrink()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.grey),
                label == null
                    ? const SizedBox.expand()
                    : Text(
                        label!,
                        style: const TextStyle(color: Colors.grey),
                      ),
              ],
            ),
    );
  }
}

class Clipper1 extends CustomClipper<Path> {
  const Clipper1(
    this.arrowWidth,
    this.arrwoHeight, {
    this.radius = 5.0,
  });

  final double arrowWidth;
  final double arrwoHeight;
  final double radius;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.addRRect(RRect.fromLTRBR(
        0, 0, size.width, size.height, Radius.circular(radius)));

    var arrowPath = Path();
    arrowPath.lineTo(arrowWidth, arrwoHeight / 2);
    arrowPath.lineTo(0, arrwoHeight);
    arrowPath.close();
    path.addPath(
        arrowPath, Offset(size.width, size.height / 2 - arrwoHeight / 2));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Clipper2 extends CustomClipper<Path> {
  final double radius;
  final double secondRadius;

  const Clipper2(this.radius, this.secondRadius);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.addRRect(RRect.fromLTRBR(
        0, 0, size.width, size.height, Radius.circular(radius)));
    var path2 = Path();
    path2.addRRect(RRect.fromLTRBAndCorners(0, 0, radius, radius,
        bottomRight: Radius.circular(secondRadius)));
    path.addPath(path2, Offset(size.width - radius, size.height - radius));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Clipper3 extends CustomClipper<Path> {
  final double radius;
  final double secondRadius;

  const Clipper3(this.radius, this.secondRadius);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.addRRect(RRect.fromLTRBR(
        0, 0, size.width, size.height, Radius.circular(radius)));
    var path2 = Path();
    path2.addRRect(RRect.fromLTRBAndCorners(0, 0, radius, radius,
        bottomRight: Radius.circular(secondRadius)));
    path.addPath(path2, Offset(size.width - radius, size.height - radius));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
