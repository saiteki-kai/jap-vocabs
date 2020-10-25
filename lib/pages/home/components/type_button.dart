import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Function onPressed;

  const TypeButton({
    Key key,
    @required this.text,
    @required this.selected,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unselectedStyle = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(fontSize: 16.0, color: Colors.white54);

    final selectedStyle = Theme.of(context)
        .textTheme
        .headline6
        .copyWith(color: Colors.white);

    return IconButton(
      icon: Text(text, style: selected ? selectedStyle : unselectedStyle),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
    );
  }
}
