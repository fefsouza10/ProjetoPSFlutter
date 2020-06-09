import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProjetoPSFlutter"),
        backgroundColor: Colors.purpleAccent,
      ),
      backgroundColor: Colors.white,
    );
  }
}
