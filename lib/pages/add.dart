import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/data/item.dart';
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

    //    List<Item> items = [
//      Item(
//          text: '学習',
//          type: 'word',
//          meaning: 'imparare, studio, tutorial',
//          reading: 'がくしゅう'),
//      Item(
//          text: '機械',
//          type: 'word',
//          meaning: 'macchina, macchinario',
//          reading: 'きかい'),
//      Item(
//          text: '無口な',
//          type: 'word',
//          meaning: 'silenzioso, taciturno',
//          reading: 'むくちな'),
//      Item(
//          text: '植物',
//          type: 'word',
//          meaning: 'pianta, vegetale',
//          reading: 'しょくぶつ'),
//      Item(
//          text: '植える',
//          type: 'word',
//          meaning: 'piantare, trapiantare, instillare',
//          reading: 'うえる'),
//      Item(
//          text: '探索',
//          type: 'word',
//          meaning: 'ricerca, cerca, investigare',
//          reading: 'たんさく'),
//      Item(text: '混乱', type: 'word', meaning: 'confusione', reading: 'こんらん'),
//    ];
//    for (Item x in items) {
//      await store.dispatch(addItem(x));
//    }
//    return;

    final form = _formKey.currentState;

    print(form.validate());
    print(widget.item == null);

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
      _strokesController.text = (_numberOfStrokes ?? '').toString();
      _partOfSpeechController.text = _partOfSpeech;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: CHECK if ALREADY exists

    final decoration = InputDecoration(
      filled: true,
      contentPadding: const EdgeInsets.all(8.0),
      //isCollapsed: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide.none,
      ),
    );

    return CustomLayout(
      appBar: AppBar(
        title: Text(
          widget.item == null ? 'Add' : 'Edit',
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
                _FieldTitle(
                    title: 'Text', padding: EdgeInsets.only(bottom: 8.0)),
                TextFormField(
                  controller: _textController,
                  decoration: decoration,
                  onSaved: (String value) {
                    setState(() => _text = value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                _FieldTitle(title: 'Meaning'),
                TextFormField(
                  controller: _meaningController,
                  decoration: decoration,
                  onSaved: (String value) {
                    setState(() => _meaning = value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                _FieldTitle(
                    title: 'JLPT',
                    padding: EdgeInsets.only(top: 16.0, bottom: 0.0)),
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
                _FieldTitle(
                    title: 'Type',
                    padding: EdgeInsets.only(top: 16.0, bottom: 0.0)),
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
                    ChipsChoiceOption(value: 'word', label: '語彙'),
                    ChipsChoiceOption(value: 'kanji', label: '漢字'),
                  ],
                  onChanged: (String value) {
                    setState(() => _type = value);
                  },
                ),
                _FieldTitle(title: 'Reading', enabled: _type == 'word'),
                TextFormField(
                  controller: _readingController,
                  decoration: decoration,
                  enabled: _type == 'word',
                  onSaved: (String value) {
                    setState(() => _reading = value);
                  },
                ),
                _FieldTitle(title: 'Part of Speech', enabled: _type == 'word'),
                TextFormField(
                  controller: _partOfSpeechController,
                  decoration: decoration,
                  enabled: _type == 'word',
                  onSaved: (String value) {
                    setState(() => _partOfSpeech = value);
                  },
                  validator: (value) {
                    if (_type != 'word') return null;

                    if (value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                _FieldTitle(
                    title: 'Number of Strokes', enabled: _type == 'kanji'),
                TextFormField(
                  controller: _strokesController,
                  keyboardType: TextInputType.number,
                  decoration: decoration,
                  enabled: _type == 'kanji',
                  onSaved: (String value) {
                    if (value != null && value.isNotEmpty)  {
                      setState(() => _numberOfStrokes = int.parse(value));
                    }
                  },
                  validator: (value) {
                    if (_type != 'kanji') return null;

                    if (value.isEmpty) {
                      return 'Required';
                    }
                    if (int.parse(value) <= 0) {
                      return 'The value must be greater than 0';
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

class _FieldTitle extends StatelessWidget {
  final String title;
  final bool enabled;
  final EdgeInsets padding;

  const _FieldTitle({Key key, this.title, this.enabled = true, this.padding})
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
