import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('Diagramación'),
          actions: const [
            Icon(Icons.more_vert),
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 229, 14, 14),
              ),
              title: const Text('Item 1'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Acción'),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 175, 76, 135),
              ),
              title: const Text('Item 2'),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Acción'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
