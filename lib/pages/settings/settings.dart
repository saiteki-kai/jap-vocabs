import 'package:flutter/material.dart';
import 'package:jap_vocab/components/custom_layout.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/pages/settings/backup_section.dart';
import 'package:jap_vocab/pages/settings/language_section.dart';
import 'package:jap_vocab/pages/settings/layout_section.dart';
import 'package:jap_vocab/pages/settings/notification_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text(S.of(context).title_settings),
              titleSpacing: 0.0,
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            ListView(
              //padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              children: [
                SettingSection(
                  child: LayoutSection(),
                ),
                SettingSection(
                  child: NotificationSection(),
                ),
                SettingSection(
                  child: BackupSection(),
                ),
                SettingSection(
                  child: LanguageSection(),
                ),
                SizedBox(height: 64.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingSection extends StatelessWidget {
  final Widget child;
  const SettingSection({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: child,
      ),
    );
  }
}
