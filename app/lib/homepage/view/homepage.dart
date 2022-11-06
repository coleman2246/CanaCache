import "package:flutter/material.dart";
import "package:app/common_widgets/canna_scaffold.dart";

class HomePage extends StatefulWidget {
  final String? title;

  const HomePage({Key? key, this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CannaScaffold(body: const Center(child: Text("Te")));
  }
}
