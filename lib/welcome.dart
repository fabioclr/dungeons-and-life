import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/main.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  _navigateToMain() async {
    await Future.delayed(const Duration(milliseconds: 10500), () {});
    final int level;
    final int expOwned;
    final List<String> doneTasksIds;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('level') != null) {
      level = prefs.getInt('level')!;
    } else {
      level = 1;
    }
    if (prefs.getInt('expOwned') != null) {
      expOwned = prefs.getInt('expOwned')!;
    } else {
      expOwned = 0;
    }
    if (prefs.getInt('date') != null &&
        DateTime.now().day == prefs.getInt('date') &&
        prefs.getStringList('doneTasksIds') != null) {
      doneTasksIds = prefs.getStringList('doneTasksIds')!;
    } else {
      prefs.setInt('date', DateTime.now().day);
      doneTasksIds = <String>[''];
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(level, expOwned, doneTasksIds)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bard.jpeg'),
                  fit: BoxFit.cover)),
        ),
        const Center(
          child: Text(
            'Olá Nobre Guerreiro !\n\n Hoje começare-mos uma nova aventura! \n\n Preparado ? Siga essas tarefas para ganhar sua experiencia. \n\n Até mais !',
            style: TextStyle(
                fontSize: 35,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ));
  }
}
