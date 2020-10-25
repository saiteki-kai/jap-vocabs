import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SummaryAppBar extends StatelessWidget {
  final List<bool> answers;
  const SummaryAppBar({this.answers});

  int get count => answers.length;
  int get correct => answers.where((x) => x).toList().length;
  double get accuracy => count == 0 ? 0 : correct / count;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('要約'),
      titleSpacing: 0.0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  '合計\n$count',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              CircularPercentIndicator(
                radius: 80,
                lineWidth: 80 / 5,
                percent: accuracy,
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: Colors.redAccent,
                progressColor: Colors.green,
              ),
              Expanded(
                child: Text(
                  '精度\n${(accuracy * 100).round()}%',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
