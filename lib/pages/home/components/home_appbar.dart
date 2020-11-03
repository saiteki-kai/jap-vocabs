import 'package:flutter/material.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/pages/home/components/filter_sheet/filter_sheet.dart';
import 'package:jap_vocab/pages/home/components/reivew_type_switch.dart';
import 'package:jap_vocab/pages/home/components/seachbar.dart';

class HomeAppBar extends StatelessWidget {
  void _onChoiceAction(BuildContext context, String choice) {
    Navigator.pushNamed(context, '/$choice');
  }

  void _onAdd(BuildContext context) {
    Navigator.pushNamed(context, '/add');
  }

  void _displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      builder: (_) {
        return FilterSheet();
      },
    );
  }

  IconData _icon(String choice) {
    switch (choice) {
      case 'favorites':
        return Icons.favorite;
      case 'settings':
        return Icons.settings;
      case 'stats':
        return Icons.assessment_rounded;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _choices = {
      'favorites': S.of(context).menu_favorite,
      'stats': S.of(context).menu_statistics,
      'settings': S.of(context).menu_settings,
    };

    return AppBar(
      title: ReviewTypeSwitch(),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          tooltip: S.of(context).tooltip_add,
          onPressed: () => _onAdd(context),
        ),
        IconButton(
          icon: Icon(Icons.filter_list),
          tooltip: S.of(context).tooltip_filter,
          onPressed: () => _displayBottomSheet(context),
        ),
        PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          tooltip: S.of(context).tooltip_menu,
          onSelected: (choice) => _onChoiceAction(context, choice),
          offset: Offset(0.0, 10.0),
          itemBuilder: (BuildContext context) {
            return _choices.entries.map((choice) {
              return PopupMenuItem<String>(
                value: choice.key,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_icon(choice.key), color: Colors.black87),
                    SizedBox(width: 8.0),
                    Text(choice.value),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ],
      bottom: SearchBar(),
    );
  }
}
