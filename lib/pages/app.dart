import 'package:flutter/material.dart';
import 'package:jap_vocab/pages/home.dart';
import 'package:jap_vocab/pages/home/home.dart';
import 'package:jap_vocab/pages/settings/settings.dart';
import 'package:jap_vocab/pages/stats.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class Destination {
  final String title;
  final IconData icon;
  final int index;
  final Widget page;

  const Destination(this.title, this.icon, this.index, this.page);
}

const _destinations = <Destination>[
  // Destination('favorite', Icons.favorite),
  Destination('復習', Icons.rotate_left, 0, HomeReviewsPage()),
  Destination('言葉', Icons.language, 1, HomePage()),
  Destination('統計', Icons.bar_chart, 2, StatsPage()),
  Destination('設定', Icons.settings, 3, SettingsPage()),
];

class _LayoutPageState extends State<LayoutPage>
    with TickerProviderStateMixin<LayoutPage> {
  var _selectedIndex = 1;
  List<Key> _destinationKeys;
  List<AnimationController> _faders;

  @override
  void initState() {
    super.initState();

    _faders = _destinations.map<AnimationController>((Destination destination) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      );
    }).toList();

    _faders[_selectedIndex].value = 1.0;

    _destinationKeys =
        List<Key>.generate(_destinations.length, (int index) => GlobalKey())
            .toList();
  }

  @override
  void dispose() {
    for (var controller in _faders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final store = StoreProvider.of<AppState>(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: _destinations.map((Destination destination) {
          final Widget view = FadeTransition(
            opacity: _faders[destination.index]
                .drive(CurveTween(curve: Curves.fastOutSlowIn)),
            child: KeyedSubtree(
              key: _destinationKeys[destination.index],
              child: destination.page,
            ),
          );
          if (destination.index == _selectedIndex) {
            _faders[destination.index].forward();
            return view;
          } else {
            _faders[destination.index].reverse();
            if (_faders[destination.index].isAnimating) {
              return IgnorePointer(child: view);
            }
            return Offstage(child: view);
          }
        }).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(blurRadius: 4.0, color: Colors.black.withOpacity(0.1)),
          ],
        ),
        child: SalomonBottomBar(
          margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          items: [
            // SalomonBottomBarItem(
            //   icon: Icon(Icons.favorite),
            //   title: Text('お気に入り'),
            // ),
            SalomonBottomBarItem(
              icon: Icon(Icons.rotate_left),
              title: Text('復習'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.language),
              title: Text('言葉'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.bar_chart),
              title: Text('統計'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text('設定'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }
}
