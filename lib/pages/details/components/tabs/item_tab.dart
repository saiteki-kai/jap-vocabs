import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/pages/details/components/tabs/examples_section.dart';

class WordTab extends StatelessWidget {
  final Item item;
  WordTab({@required this.item});

  int get _hex => item.text.codeUnits.first;
  bool get _isWord => item.type == 'word';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).primaryColorLight,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.text,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                  if (item.jlpt != null)
                    Text('N${item.jlpt}',
                        style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
              ItemInfo(
                title: item.type == 'kanji'
                    ? S.of(context).item_writing
                    : S.of(context).item_reading,
                subtitle: item.type == 'kanji'
                    ? Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        color: Colors.white,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SvgPicture.asset(
                            'assets/kanji/${_hex}_frames.svg',
                            height: 64.0,
                          ),
                        ),
                      )
                    : Text(
                        item.reading,
                        style: TextStyle(fontSize: 16.0),
                      ),
              ),
              ItemInfo(
                title: S.of(context).item_meaning,
                subtitle: item.meaning,
              ),
              if (_isWord)
                ItemInfo(
                  title: S.of(context).item_partofspeech,
                  subtitle: item.partOfSpeech ?? '-',
                )
              else
                ItemInfo(
                  title: S.of(context).item_numberofstrokes,
                  subtitle: item.numberOfStrokes?.toString() ?? '-',
                ),
            ],
          ),
        ),
        Expanded(
          child: ExamplesSection(item: item),
        ),
      ],
    );
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key key, @required this.title, @required this.subtitle})
      : super(key: key);

  final String title;
  final dynamic subtitle;

  @override
  Widget build(BuildContext context) {
    final _subtitle = TextStyle(color: Color(0xffff7e65), fontSize: 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.0),
        Text(title, style: _subtitle),
        if (subtitle is String)
          Text(subtitle, style: TextStyle(fontSize: 16.0))
        else
          subtitle,
      ],
    );
  }
}
