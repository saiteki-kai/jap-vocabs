import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget floatingActionButton;

  const CustomLayout(
      {@required this.body, this.appBar, this.floatingActionButton, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding;

    if (appBar == null) {
      final statusHeight = MediaQuery.of(context).padding.top;
      padding = EdgeInsets.only(top: statusHeight);
    }

    return Scaffold(
      body: Container(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            IntrinsicHeight(child: appBar ?? Container()),
            Expanded(child: body),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
