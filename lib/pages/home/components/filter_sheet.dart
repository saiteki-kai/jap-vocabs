import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  FilterSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SortSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),
          FilterSection(),
        ],
      ),
    );
  }
}

class FilterSection extends StatefulWidget {
  FilterSection({Key key}) : super(key: key);

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  var _partOfSpeech = [];
  var _jlpt = [];
  var _level = [];

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1.copyWith(
          // color: Theme.of(context).accentColor,
          fontWeight: FontWeight.bold,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text('フィルター', style: style),
        ),
        ChipsChoice.multiple(
          value: _partOfSpeech,
          options: [
            ChipsChoiceOption(value: '動詞', label: '動詞'),
            ChipsChoiceOption(value: '名詞', label: '名詞'),
            ChipsChoiceOption(value: '形容詞', label: '形容詞'),
            ChipsChoiceOption(value: '名形容動詞', label: '名形容動詞'),
          ],
          onChanged: (value) => setState(() => _partOfSpeech = value),
          itemConfig: ChipsChoiceItemConfig(
            showCheckmark: false,
            unselectedBrightness: Brightness.dark,
            selectedBrightness: Brightness.dark,
          ),
          isWrapped: true,
        ),
        ChipsChoice.multiple(
          value: _jlpt,
          options: [
            ChipsChoiceOption(value: 5, label: 'N5'),
            ChipsChoiceOption(value: 4, label: 'N4'),
            ChipsChoiceOption(value: 3, label: 'N3'),
            ChipsChoiceOption(value: 2, label: 'N2'),
            ChipsChoiceOption(value: 1, label: 'N1'),
          ],
          onChanged: (value) => setState(() => _jlpt = value),
          itemConfig: ChipsChoiceItemConfig(
            showCheckmark: false,
            unselectedBrightness: Brightness.dark,
            selectedBrightness: Brightness.dark,
          ),
          isWrapped: true,
        ),
        ChipsChoice.multiple(
          value: _level,
          options: [
            ChipsChoiceOption(value: 'weak', label: 'Weak'),
            ChipsChoiceOption(value: 'medium', label: 'Medium'),
            ChipsChoiceOption(value: 'strong', label: 'Strong'),
          ],
          onChanged: (value) => setState(() => _level = value),
          itemConfig: ChipsChoiceItemConfig(
            showCheckmark: false,
            unselectedBrightness: Brightness.dark,
            selectedBrightness: Brightness.dark,
          ),
          isWrapped: true,
        ),
      ],
    );
  }
}

class SortSection extends StatelessWidget {
  SortSection({Key key}) : super(key: key);

  final sorts = [
    'Alphabetical',
    'Next Review',
    'Last Review',
    'Streak',
    'Accuracy'
  ];

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1.copyWith(
          // color: Theme.of(context).accentColor,
          fontWeight: FontWeight.bold,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text('並べ替え', style: style),
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: sorts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                sorts[index],
                style:
                    TextStyle(color: index == 2 ? Colors.orangeAccent : null),
              ),
              selected: index == 2,
              // selectedTileColor: Colors.red,
              trailing: index == 2
                  ? Icon(Icons.arrow_upward, color: Colors.orangeAccent)
                  : null,
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}
