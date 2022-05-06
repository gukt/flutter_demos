import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Home()));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 用于描述当前 App 信息, 可指定 app 的名称，版本，图标，
            // 底部带有两个按钮：查看许可按钮和关闭按钮。
            // 底部按钮默认显示英文（VIEW LICENCES、CLOSE），如果要显示中文，你需要配置国际化和本地语言
            showAboutDialog(
              context: context,
              applicationName: '演示程序',
              applicationVersion: '1.0.0',
              applicationIcon: const FlutterLogo(size: 50),
              // 法律措辞
              applicationLegalese:
                  'Copyright @2020-2022, codedog996.com All Rights Reserved.',
              children: <Widget>[
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: [
                    Container(width: 15, height: 15, color: Colors.red),
                    Container(width: 15, height: 15, color: Colors.orange),
                    Container(width: 15, height: 15, color: Colors.yellow),
                    Container(width: 15, height: 15, color: Colors.green),
                    Container(width: 15, height: 15, color: Colors.cyan),
                    Container(width: 15, height: 15, color: Colors.blue),
                    Container(width: 15, height: 15, color: Colors.purple),
                    Container(width: 15, height: 15, color: Colors.red),
                    Container(width: 15, height: 15, color: Colors.orange),
                    Container(width: 15, height: 15, color: Colors.yellow),
                    Container(width: 15, height: 15, color: Colors.green),
                    Container(width: 15, height: 15, color: Colors.cyan),
                    Container(width: 15, height: 15, color: Colors.blue),
                    Container(width: 15, height: 15, color: Colors.purple),
                  ],
                ),
                Container(height: 15, color: Colors.red),
                Container(height: 15, color: Colors.orange),
                Container(height: 15, color: Colors.yellow),
                Container(height: 15, color: Colors.green),
                Container(height: 15, color: Colors.cyan),
                Container(height: 15, color: Colors.blue),
                Container(height: 15, color: Colors.purple),
              ],
            );
          },
          child: const Text('打开“关于”对话框'),
        ),
      ),
    );
  }
}
