import 'package:flutter/material.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/models/example.dart';
import 'package:substring_highlight/substring_highlight.dart';

class ExamplesSection extends StatelessWidget {
  final Item item;
  const ExamplesSection({this.item});

  String get _text => item.text;
  List<Example> get _examples => item.examples;
  int get _count => _examples?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    return _count == 0
        ? Container(
            child: Center(
              child: Text(
                'No Examples Inserted Yet',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.only(bottom: 80.0),
            shrinkWrap: true,
            itemCount: _count,
            itemBuilder: (context, index) {
              final example = _examples[index];
              return ExampleItem(item: _text, example: example);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0);
            },
          );
  }
}

class ExampleItem extends StatelessWidget {
  final Example example;
  final String item;

  const ExampleItem({Key key, @required this.item, @required this.example})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubstringHighlight(
            text: example.text,
            term: item,
            textStyle: Theme.of(context).textTheme.headline6,
            textStyleHighlight: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(example.translation),
        ],
      ),
    );
  }
}
