import 'package:flutter/material.dart';
import 'package:jap_vocab/components/md2_indicator.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/pages/home/components/filter_sheet/components/filter_section.dart';
import 'package:jap_vocab/pages/home/components/filter_sheet/components/sort_section.dart';

class FilterSheet extends StatelessWidget {
  FilterSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsets.only(top: 4),
              child: TabBar(
                tabs: [
                  Tab(text: S.of(context).sort),
                  Tab(text: S.of(context).filter),
                ],
                unselectedLabelColor: Colors.white30,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MD2Indicator(
                  indicatorHeight: 4.0,
                  indicatorColor: Colors.white,
                  horizontalPadding: 16.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColorLight,
                child: TabBarView(
                  children: [
                    SortSection(),
                    FilterSection(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
