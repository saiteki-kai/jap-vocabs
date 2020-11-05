import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/pages/add/components/field_title.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';

class AddPage extends StatefulWidget {
  final Item item;
  const AddPage({this.item});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String _text;
  String _meaning;
  String _reading;
  String _partOfSpeech;
  String _type = 'word';
  int _numberOfStrokes;
  int _jlpt;

  final _formKey = GlobalKey<FormState>();

  void _onSave() async {
    final store = StoreProvider.of<AppState>(context);
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      if (widget.item == null) {
        await store.dispatch(
          addItem(
            Item(
              text: _text,
              type: _type,
              meaning: _meaning,
              reading: _reading,
              jlpt: _jlpt,
              numberOfStrokes: _numberOfStrokes,
              partOfSpeech: _partOfSpeech,
            ),
          ),
        );
      } else {
        await store.dispatch(
          updateItem(
            widget.item.copyWith(
              text: _text,
              type: _type,
              meaning: _meaning,
              reading: _reading,
              partOfSpeech: _partOfSpeech,
              numberOfStrokes: _numberOfStrokes,
              jlpt: _jlpt,
            ),
          ),
        );
      }

      Navigator.pop(context);
    }
  }

  TextEditingController _textController;
  TextEditingController _meaningController;
  TextEditingController _readingController;
  TextEditingController _strokesController;
  TextEditingController _partOfSpeechController;

  @override
  void initState() {
    _textController = TextEditingController();
    _meaningController = TextEditingController();
    _readingController = TextEditingController();
    _strokesController = TextEditingController();
    _partOfSpeechController = TextEditingController();

    if (widget.item != null) {
      _text = widget.item.text;
      _meaning = widget.item.meaning;
      _reading = widget.item.reading;
      _type = widget.item.type;
      _partOfSpeech = widget.item.partOfSpeech;
      _numberOfStrokes = widget.item.numberOfStrokes;
      _jlpt = widget.item.jlpt;

      _textController.text = _text;
      _meaningController.text = _meaning;
      _readingController.text = _reading;
      _strokesController.text = _numberOfStrokes?.toString() ?? '';
      _partOfSpeechController.text = _partOfSpeech;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: AppBar(
        title: Text(
          widget.item == null
              ? S.of(context).title_add
              : S.of(context).title_edit,
        ),
        titleSpacing: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _onSave,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldTitle(
                  title: S.of(context).item_text,
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                TextFormField(
                  controller: _textController,
                  onSaved: (String value) {
                    setState(() => _text = value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return S.of(context).validation_required;
                    }
                    return null;
                  },
                ),
                FieldTitle(title: S.of(context).item_meaning),
                TextFormField(
                  controller: _meaningController,
                  onSaved: (String value) {
                    setState(() => _meaning = value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return S.of(context).validation_required;
                    }
                    return null;
                  },
                ),
                FieldTitle(
                  title: 'JLPT',
                  padding: EdgeInsets.only(top: 16.0, bottom: 0.0),
                ),
                ChipsChoice<int>.single(
                  value: _jlpt,
                  isWrapped: true,
                  padding: EdgeInsets.zero,
                  itemConfig: ChipsChoiceItemConfig(
                    showCheckmark: false,
                    selectedBrightness: Brightness.dark,
                    unselectedBrightness: Brightness.dark,
                    selectedColor: Theme.of(context).accentColor,
                    unselectedColor: Colors.grey.shade400,
                  ),
                  options: [
                    ChipsChoiceOption(value: 5, label: 'N5'),
                    ChipsChoiceOption(value: 4, label: 'N4'),
                    ChipsChoiceOption(value: 3, label: 'N3'),
                    ChipsChoiceOption(value: 2, label: 'N2'),
                    ChipsChoiceOption(value: 1, label: 'N1'),
                  ],
                  onChanged: (int value) {
                    setState(() => _jlpt = value);
                  },
                ),
                FieldTitle(
                  title: S.of(context).item_type,
                  padding: EdgeInsets.only(top: 16.0, bottom: 0.0),
                ),
                ChipsChoice<String>.single(
                  value: _type,
                  isWrapped: true,
                  padding: EdgeInsets.zero,
                  itemConfig: ChipsChoiceItemConfig(
                    showCheckmark: false,
                    selectedBrightness: Brightness.dark,
                    unselectedBrightness: Brightness.dark,
                    selectedColor: Theme.of(context).accentColor,
                    unselectedColor: Colors.grey.shade400,
                  ),
                  options: [
                    ChipsChoiceOption(
                      value: 'word',
                      label: S.of(context).tab_word,
                    ),
                    ChipsChoiceOption(
                      value: 'kanji',
                      label: S.of(context).tab_kanji,
                    ),
                  ],
                  onChanged: (String value) {
                    setState(() => _type = value);
                  },
                ),
                FieldTitle(
                  title: S.of(context).item_reading,
                  enabled: _type == 'word',
                ),
                TextFormField(
                  controller: _readingController,
                  enabled: _type == 'word',
                  onSaved: (String value) {
                    setState(() => _reading = value);
                  },
                ),
                FieldTitle(
                  title: S.of(context).item_partofspeech,
                  enabled: _type == 'word',
                ),
                TextFormField(
                  controller: _partOfSpeechController,
                  enabled: _type == 'word',
                  onSaved: (String value) {
                    setState(() => _partOfSpeech = value);
                  },
                  validator: (value) {
                    if (_type != 'word') return null;

                    if (value.isEmpty) {
                      return S.of(context).validation_required;
                    }
                    return null;
                  },
                ),
                FieldTitle(
                  title: S.of(context).item_numberofstrokes,
                  enabled: _type == 'kanji',
                ),
                TextFormField(
                  controller: _strokesController,
                  keyboardType: TextInputType.number,
                  enabled: _type == 'kanji',
                  onSaved: (String value) {
                    if (value != null && value.isNotEmpty) {
                      setState(() => _numberOfStrokes = int.parse(value));
                    }
                  },
                  validator: (value) {
                    if (_type != 'kanji') return null;

                    if (value.isEmpty) {
                      return S.of(context).validation_required;
                    }
                    if (int.parse(value) <= 0) {
                      return S.of(context).validation_positive;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
