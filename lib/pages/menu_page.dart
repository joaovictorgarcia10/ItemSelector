import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text("Itens Selector"),
              onPressed: () {
                Navigator.pushNamed(context, "/select");
              },
            ),
            const SizedBox(height: 20.0),
            TextButton(
              child: const Text("Auto Complete"),
              onPressed: () {
                Navigator.pushNamed(context, "/autocomplete");
              },
            ),
          ],
        ),
      ),
    );
  }
}
