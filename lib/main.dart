import 'package:flutter/material.dart';
import 'package:topic_selector/pages/autocomplete/autocomplete_page.dart';
import 'package:topic_selector/pages/menu_page.dart';
import 'package:topic_selector/pages/selectable/select_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MenuPage(),
        "/select": (context) => const SelectPage(title: "Select your contacts"),
        "/autocomplete": (context) => const AutocompletePage(),
      },
    );
  }
}
