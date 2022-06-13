import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/components/chart.dart';
import 'package:to_do_list/components/task_list.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/welcome.dart';

main() => runApp(ToDoList());

class ToDoList extends StatefulWidget {

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: Welcome(),
      // MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.grey[700],
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final int level;
  final int expOwned;
  final List<String> doneTasksIds;
  const MyHomePage(this.level, this.expOwned, this.doneTasksIds);

  @override
  State<MyHomePage> createState() => _MyHomePageState(level, expOwned, doneTasksIds);

}

class _MyHomePageState extends State<MyHomePage> {
  int level = 1;
  int expOwned;
  List<String> doneTasksIds;
  _MyHomePageState(this.level, this.expOwned, this.doneTasksIds);


  @override
  void initState() {
    _removeCompletedTasks(doneTasksIds);
    super.initState();
  }

  final List<Task> _task = [
    Task(
        id: 't1',
        description:
            'Tomar um café da manha reforçado ! Um grande guerreiro não vence batalhas de estomago vazio.',
        experience: 5),
    Task(
        id: 't2',
        description:
            'Cuide da sua higiene pessoal ! Que dozela(o) irá lhe querer fedendo a gambá ? Ou com bafó?',
        experience: 5),
    Task(
        id: 't3',
        description:
            'Ajude na limpeza !  Sujeira atrai tristeza ! Sujo, ninguem lhe dará titulos de Nobreza.',
        experience: 5),
    Task(
        id: 't4',
        description:
            'Trabalhar ou Estudar ! Um(a) grande guerreiro(a) possui grandes responsabilidades.',
        experience: 5),
    Task(
        id: 't5',
        description:
            'Exerciciois ! Sem eles não há quem aguente as batalhas do seu dia-a-dia, desafie-se !',
        experience: 5),
    Task(
        id: 't6',
        description:
            'Tome ÁGUA ! Tomou ? Certeza ?!? Só assim que seus rins não terão que batalhar contra pedras de mãos vazias.',
        experience: 5),
    Task(
        id: 't7',
        description:
            'Durma bem ! Dormir ? Sim, durante o sono que você se recupera de seu dia cheio de missões e batalhas, seu sono é sua fonte de mágica de energia.',
        experience: 5),
    Task(
        id: 't8',
        description:
            'Divirta-se ! Aproveitar a jornada também faz parte da sua evolução.',
        experience: 5),
    Task(
        id: 't9',
        description:
            'Cuide de seus animais ! Seja ele qual for cachorro, gato ou dragão.',
        experience: 5),
    Task(
        id: 't10',
        description:
            'Ame ! Envie uma mensagem para alguma pessoa querida, seja pai ou mãe, esposa(o) ou amante, mas ande logo ! As corujas mensageiras estão em falta ultimamente.',
        experience: 5),
  ];

  _removeCompletedTasks(List<String> doneTasksIds) {
    for (int i = 0; i < doneTasksIds.length ; i++) {
      _task.removeWhere((ts) {
        return ts.id == doneTasksIds[i];
      });
    }
  }

  final List<Task> _doneTasks = [];


  _completeTask(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _task.removeWhere((ts) {
        if (ts.id == id) {
          _doneTasks.add(ts);
          doneTasksIds.add(id);
          prefs.setStringList('doneTasksIds', doneTasksIds);
          expOwned += ts.experience;
          prefs.setInt('expOwned', expOwned);
          level = _verifyLevel(prefs);
          prefs.setInt('level', level);
        }
        return ts.id == id;
      });
    });
  }

  _verifyLevel(SharedPreferences prefs) {
    if (level == 1 && expOwned < 50) {
      return 1;
    } else if (level == 2 && expOwned < 100) {
      return 2;
    } else if (level == 3 && expOwned < 150) {
      return 3;
    } else if (level == 4 && expOwned < 200) {
      return 4;
    } else if (level == 5 && expOwned < 250) {
      return 5;
    } else if (level == 6 && expOwned < 300) {
      return 6;
    } else if (level == 7 && expOwned < 350) {
      return 7;
    } else if (level == 8 && expOwned < 400) {
      return 8;
    } else if (level == 9 && expOwned < 450) {
      return 9;
    } else if (level == 10 && expOwned < 500) {
      return 10;
    } else {
      expOwned = 0;
      prefs.setInt('expOwned', 0);
      return level + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dungeons & Life'),
        ),
        body: Container(
          decoration: _task.isEmpty
              ? const BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage('assets/images/rest.jpeg'),
                  fit: BoxFit.cover,
                ))
              : const BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage('assets/images/warfield.jpeg'),
                  fit: BoxFit.cover,
                )),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Chart(_doneTasks, expOwned, level),
              const SizedBox(
                height: 3,
              ),
              TaskList(_task, _completeTask),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: const Text(
                      'Nobres Guerreiros não mentem ! Então se porte como um ! Não finalize uma tarefa sem realmente ter feito, não comprometa sua evolução, só covardes pegam atalhos !',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                  elevation: 5,
                ),
              )
            ],
          ),
        ));
  }
}
