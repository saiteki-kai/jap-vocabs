import 'package:flutter/material.dart';
import 'package:jap_vocab/generated/l10n.dart';

Future<bool> showConfirmDialog(
  context, {
  String message,
  String buttonText,
  Function onConfirm,
}) async {
  return await showDialog<bool>(
    context: context,
    // barrierDismissible: false,
    builder: (_) => AlertDialog(
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text(S.of(context).button_cancel),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Text(buttonText),
          onPressed: () {
            Navigator.pop(context, true);
            if (onConfirm != null) onConfirm();
          },
        ),
      ],
    ),
  );
}
