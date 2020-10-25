import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewAppBar extends StatelessWidget {
  final int current;
  final int total;
  final Function onSummary;

  const ReviewAppBar({this.current, this.total, this.onSummary});

  double get _percent => total == 0 ? 0.0 : (current + 1.0) / total;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('復習'),
      titleSpacing: 0.0,
      actions: [
        IconButton(
          icon: Icon(Icons.pie_chart),
          onPressed: onSummary,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Column(
          children: [
            SizedBox(height: 8.0),
            Text(
              '${current + 1} / $total',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: LinearPercentIndicator(
                lineHeight: 10.0,
                percent: _percent,
                backgroundColor: Colors.black.withOpacity(0.1),
                progressColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
