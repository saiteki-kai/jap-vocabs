import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/pages/details/components/details_appbar.dart';
import 'package:jap_vocab/pages/details/components/phrase_dialog.dart';
import 'package:jap_vocab/pages/details/components/tabs/item_tab.dart';
import 'package:jap_vocab/pages/details/components/tabs/reviews_tab.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';
import 'package:redux/redux.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({this.id});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController _animationController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);

    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    _animationController.forward();

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _openDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return PhraseDialog(itemId: widget.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => store,
      onInitialBuild: (store) => store.dispatch(getItem(widget.id)),
      builder: (context, Store<AppState> store) {
        final item = store.state.itemsState.item;

        if (item == null) {
          return Material(
            child: Center(child: Text(S.of(context).loading)),
          );
        }

        return CustomLayout(
          appBar: DetailsAppBar(
            item: item,
            controller: _tabController,
            tabs: [
              item.type == 'word'
                  ? S.of(context).tab_word
                  : S.of(context).tab_kanji,
              S.of(context).tab_review
            ],
            onTabChange: (index) {
              if (_tabController.index == 0) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            },
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              WordTab(item: item),
              ReviewsTab(item: item),
            ],
          ),
          floatingActionButton: ScaleTransition(
            scale: _animationController,
            child: FloatingActionButton(
              /*shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),*/
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                _openDialog(context);
              },
            ),
          ),
        );
      },
    );
  }
}
