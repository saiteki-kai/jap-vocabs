import 'package:flutter/material.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/pages/settings/backup_section.dart';
import 'package:jap_vocab/pages/settings/language_section.dart';
import 'package:jap_vocab/pages/settings/layout_section.dart';
import 'package:jap_vocab/pages/settings/notification_section.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: AppBar(
        title: Text(S.of(context).settings_title),
        titleSpacing: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          LayoutSection(),
          Divider(height: 0, thickness: 1),
          NotificationSection(),
          Divider(height: 0, thickness: 1),
          BackupSection(),
          Divider(height: 0, thickness: 1),
          LanguageSection(),
          SizedBox(height: 128.0),
        ],
      ),
    );
  }
}
