import 'package:flutter/material.dart';
import 'package:to_do_list/components/chart_bar.dart';
import 'package:to_do_list/models/task.dart';

class Chart extends StatelessWidget {

  final List<Task> doneTasks;
  final int expOwned;
  final int level;

  Chart(this.doneTasks, this.expOwned, this.level);

  int required() {
    if (level < 11) {
      return level * 50;
    } else{
      return 100;
    }
  }

  double percentage() {
    return (expOwned)/ required();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: const Text(
                'Jornada',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              )),
          const SizedBox(
            width: 50,
          ),
          ChartBar(percentage(), level, expOwned)
        ],
      ),
    );
  }
}
