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
        body: ListaTarefas(),
      ),
    );
  }
}

class ListaTarefas extends StatefulWidget {
  @override
  _ListaTarefasState createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  List<Tarefa> tarefas = [];

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _anotacaoController = TextEditingController();

  void adicionarTarefa() {
    print(
        "Titulo: ${_tituloController.text},\n Anotação: ${_anotacaoController.text}");

    setState(() {
      tarefas.add(Tarefa(_tituloController.text, _anotacaoController.text));
    });

    _tituloController.text = '';
    _anotacaoController.text = '';
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _anotacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputDados(_tituloController, _anotacaoController, adicionarTarefa),
        Column(
          children: [
            for (var item in tarefas)
              Text("Titulo: ${item.titulo},\n Anotação: ${item.anotacao}")
          ],
        )
      ],
    );
  }
}

class Tarefa {
  String titulo;
  String anotacao;

  Tarefa(this.titulo, this.anotacao);
}

class InputDados extends StatelessWidget {
  final TextEditingController _tituloController;
  final TextEditingController _anotacaoController;
  final void Function() adicionarTarefa;

  const InputDados(
      this._tituloController, this._anotacaoController, this.adicionarTarefa,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
            child: SizedBox(
              child: TextField(
                controller: _tituloController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: 'Titulo'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
            child: SizedBox(
              child: TextField(
                controller: _anotacaoController,
                maxLines: 3,
                minLines: 1,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: 'Anotação'),
              ),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: adicionarTarefa,
            label: const Text('Adicionar'),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
