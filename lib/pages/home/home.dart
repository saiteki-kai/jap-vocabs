import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/pages/home/components/filter_section.dart';
import 'package:jap_vocab/pages/home/components/sort_section.dart';
import 'package:jap_vocab/pages/home/components/list_item.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/pages/home/components/reivew_type_switch.dart';
import 'package:jap_vocab/pages/home/components/seachbar.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/items.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _backLayerType = '';

  Widget get _backLayer {
    switch (_backLayerType) {
      case 'sort':
        return SortSection();
      case 'filter':
        return FilterSection();
      //case 'search':
      //  return SearchBar();
      default:
        return null;
    }
  }

  double get _frontLayerHeight {
    switch (_backLayerType) {
      case 'sort':
        return 340;
      case 'filter':
        return 280;
      //case 'search':
      //  return 470;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.create(store),
      onInit: (Store<AppState> store) => store.dispatch(getItems()),
      builder: (context, _ViewModel vm) {
        final count = vm.items?.length ?? 0;

        return Listener(
          child: BackdropScaffold(
            headerHeight: _frontLayerHeight,
            //resizeToAvoidBottomInset: true,
            appBar: BackdropAppBar(
              automaticallyImplyLeading: false,
              title: ReviewTypeSwitch(),
              bottom: PreferredSize(
                child: LayoutBuilder(
                  builder: (context, constraints) => SearchBar(
                    onTap: () {
                      if (Backdrop.of(context).isBackLayerRevealed) {
                        Backdrop.of(context).concealBackLayer();
                      }
                    },
                  ),
                ),
                preferredSize: Size.fromHeight(48.0 + 12.0),
              ),
              actions: <Widget>[
                /*LayoutBuilder(
                  builder: (context, constraints) => IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      FocusScope.of(context)?.unfocus();
                      if (_backLayerType == 'search') {
                        Backdrop.of(context).fling();
                      } else {
                        setState(() => _backLayerType = 'search');
                        Backdrop.of(context).revealBackLayer();
                      }
                    },
                  ),
                ),*/
                LayoutBuilder(
                  builder: (context, constraints) => IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () {
                      FocusScope.of(context)?.unfocus();
                      if (_backLayerType == 'sort') {
                        Backdrop.of(context).fling();
                      } else {
                        setState(() => _backLayerType = 'sort');
                        Backdrop.of(context).revealBackLayer();
                      }
                    },
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => IconButton(
                    icon: Icon(Icons.tune),
                    onPressed: () {
                      FocusScope.of(context)?.unfocus();
                      if (_backLayerType == 'filter') {
                        Backdrop.of(context).fling();
                      } else {
                        setState(() => _backLayerType = 'filter');
                        Backdrop.of(context).revealBackLayer();
                      }
                    },
                  ),
                )
              ],
            ),
            backLayer: _backLayer,
            subHeader: BackdropSubHeader(
              title: Text('$count Items'),
              divider: Divider(height: 0, indent: 16, endIndent: 16),
            ),
            frontLayer: count > 0
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: vm.items?.length ?? 0,
                    itemBuilder: (_, index) {
                      return ListItem(
                        item: vm.items[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: {'id': vm.items[index].id},
                          );
                        },
                      );
                    },
                  )
                : Center(
                    child: Text('No items'),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add');
              },
              child: Icon(Icons.add, color: Colors.white),
              // label: Text(
              //   S.of(context).tooltip_add,
              //   style: TextStyle(color: Colors.white),
              // ),
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List<Item> items;
  final Function getAllItems;

  _ViewModel({this.items, this.getAllItems});

  factory _ViewModel.create(Store<AppState> store) {
    final _items = store.state.itemsState.items;

    void _getItems() {
      store.dispatch(getItems());
    }

    return _ViewModel(
      items: _items,
      getAllItems: _getItems,
    );
  }
}
