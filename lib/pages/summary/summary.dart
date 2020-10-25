import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/data/answer.dart';
import 'package:jap_vocab/pages/summary/components/list_item.dart';
import 'package:jap_vocab/pages/summary/components/summary_appbar.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';

class SummaryPage extends StatelessWidget {
  final List<Answer> answers;
  const SummaryPage({@required this.answers});

  List<bool> get _corrects => answers.map((x) => x.correct).toList();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final store = StoreProvider.of<AppState>(context);
        await store.dispatch(getItems());
        return Future.value(true);
      },
      child: CustomLayout(
        appBar: SummaryAppBar(answers: _corrects),
        body: Container(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: answers?.length ?? 0,
            itemBuilder: (context, index) {
              return ListItem(answer: answers[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0);
            },
          ),
        ),
      ),
    );
  }
}
