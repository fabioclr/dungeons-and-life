import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double percentage;
  final int level;
  final int expOwned;

  ChartBar(
    this.percentage,
    this.level,
    this.expOwned,
  );

  String getNextLevelRequiredExp(int level) {
    if (level < 11) {
      return 'Exp necessária para evoluir: $expOwned/${level * 50}';
    } else {
      return 'Uau! Você chegou no nível máximo!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Nível: $level',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 10,
          width: 200,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          getNextLevelRequiredExp(level),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
