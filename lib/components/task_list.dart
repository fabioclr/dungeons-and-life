import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final void Function(String) onCompletTask;

  TaskList(this.tasks, this.onCompletTask);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: tasks.isEmpty
          ? Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'Pronto Nobre Guerreiro(a)!\nChegue mais perto na fogueira e se aqueça.\n Desanse que amanhã será um novo dia, com novos desafios e batalhas.',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (ctx, index) {
                final ts = tasks[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    leading: CircleAvatar (
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                          child: FittedBox (
                            child: Text('${ts.experience} xp',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                      ),
                    ),
                    title: Text(
                      ts.description,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.check_circle_rounded),
                      onPressed: () { onCompletTask(ts.id); },
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
