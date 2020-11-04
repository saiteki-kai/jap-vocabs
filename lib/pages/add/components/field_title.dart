import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;
  final bool enabled;
  final EdgeInsets padding;

  const FieldTitle({Key key, this.title, this.enabled = true, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 8.0, top: 20.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(color: enabled ? null : Colors.black54),
      ),
    );
  }
}
