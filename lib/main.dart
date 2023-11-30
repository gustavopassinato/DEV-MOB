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

  List<Widget> topPageContent = [];

  int currentTopPageContentIndex = 1;

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _anotacaoController = TextEditingController();

  void adicionarTarefa() {
    String titulo = _tituloController.text;
    String anotacao = _anotacaoController.text;

    _tituloController.text = '';
    _anotacaoController.text = '';

    setState(() {
      tarefas.add(
          Tarefa(titulo, anotacao, Object.hash(titulo, anotacao).toString()));

      currentTopPageContentIndex = 1;
    });
  }

  void exibirInput() {
    setState(() {
      currentTopPageContentIndex = 0;
    });
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _anotacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    topPageContent.clear();
    topPageContent.add(
        InputDados(_tituloController, _anotacaoController, adicionarTarefa));
    topPageContent.add(NovaTarefaButton(exibirInput));

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          topPageContent[currentTopPageContentIndex],
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Divider(
              thickness: 2,
              color: Colors.black38,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: tarefas.length,
            itemBuilder: (BuildContext context, index) {
              return TarefaCard(tarefas[index].titulo, tarefas[index].anotacao);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )
        ],
      ),
    );
  }
}

class TarefaCard extends StatelessWidget {
  final String titulo;
  final String anotacao;

  const TarefaCard(this.titulo, this.anotacao, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.circle_outlined,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      anotacao,
                      style: const TextStyle(color: Colors.black38, fontSize: 12),
                    )
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                size: 20,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NovaTarefaButton extends StatelessWidget {
  final void Function() handleNewTask;

  const NovaTarefaButton(this.handleNewTask, {super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: handleNewTask,
      label: const Text(
        'Criar Nova Tarefa',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.add),
    );
  }
}

class Tarefa {
  String titulo;
  String anotacao;
  String id;
  bool status = false;

  Tarefa(this.titulo, this.anotacao, this.id);
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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
            icon: const Icon(Icons.check),
          )
        ],
      ),
    );
  }
}
