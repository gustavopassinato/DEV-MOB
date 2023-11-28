import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("TODO"),
          ),
        ),
      ),
    );
  }
}

class ListaTarefas extends StatefulWidget {


  @override
  _ListaTarefasState createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {

  @override
  Widget build(BuildContext context) {
    return Text('aa');
  }
}