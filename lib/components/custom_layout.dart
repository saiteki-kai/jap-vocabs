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
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            IntrinsicHeight(child: appBar ?? Container()),
            Expanded(
              child: Container(
                child: body,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
    );
  }
}
