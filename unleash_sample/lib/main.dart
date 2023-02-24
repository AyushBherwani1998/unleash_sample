import 'package:flutter/material.dart';
import 'package:unleash_proxy_client_flutter/unleash_proxy_client_flutter.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unleash Demo"),
      ),
      body: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRedColorEnabled = false;

  late final UnleashClient unleashClient;

  @override
  void initState() {
    unleashClient = UnleashClient(
      url: Uri.parse("http://127.0.0.1:4242/api/frontend"),
      clientKey:
          "*:development.7b2694df91b56f8836091ff721a8a26a93bb5dd939ab96576db57d36",
      appName: "unleash-sample",
    );

    unleashClient.on('ready', (data) => updateColorFlag(data));
    unleashClient.on('update', (data) => updateColorFlag(data));
    unleashClient.start();
    super.initState();
  }

  void updateColorFlag(_) {
    setState(() {
      isRedColorEnabled = unleashClient.isEnabled('isRedColorEnabled');
    });
  }

  Color get resolveColor {
    return isRedColorEnabled ? Colors.red : Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 300,
        color: resolveColor,
      ),
    );
  }
}
