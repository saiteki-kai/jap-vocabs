import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/models/example.dart';
import 'package:jap_vocab/redux/thunk/items.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:uuid/uuid.dart';

class PhraseDialog extends StatefulWidget {
  final String itemId;
  const PhraseDialog({this.itemId});

  @override
  _PhraseDialogState createState() => _PhraseDialogState();
}

class _PhraseDialogState extends State<PhraseDialog> {
  final _keyForm = GlobalKey<FormState>();

  String _text;
  String _translation;

  void _onPressed() async {
    final store = StoreProvider.of<AppState>(context);
    var form = _keyForm.currentState;

    if (form.validate()) {
      form.save();

      await store.dispatch(
        addExample(
          widget.itemId,
          Example(
            id: Uuid().v1(),
            text: _text,
            translation: _translation,
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      content: Form(
        key: _keyForm,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phrase',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 8.0),
              TextFormField(
                maxLines: 2,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onSaved: (String value) => setState(() => _text = value),
              ),
              SizedBox(height: 16.0),
              Text(
                'Translation',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: 8.0),
              TextFormField(
                maxLines: 2,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
                onSaved: (String value) => setState(() => _translation = value),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: _onPressed,
        ),
      ],
    );
  }
}
