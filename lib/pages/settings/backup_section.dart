import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:flutter/material.dart';
import 'package:jap_vocab/database/app_database.dart';
import 'package:jap_vocab/generated/l10n.dart';
import 'package:jap_vocab/utils/date.dart';
import 'package:jap_vocab/pages/details/components/confirm_dialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupSection extends StatelessWidget {
  Future<String> get _backupPath async {
    var extDirectories = await getExternalStorageDirectories();

    var dirs = extDirectories[1].toString().split('/');
    var path = '/' + dirs[1] + '/' + dirs[2] + '/';

    return join(path, 'vocabs.backup');
  }

  Future<void> _createBackup() async {
    final granted = await Permission.storage.request().isGranted;

    if (!granted) return;

    final info = await FilePickerWritable().openFileForCreate(
      fileName: 'vocabs.backup',
      writer: (file) async {
        await AppDatabase.exportDB(file);
      },
    );

    if (info == null) {
      // TODO: Handle Error
    }
  }

  Future<void> _restoreBackup(context) async {
    final granted = await Permission.storage.request().isGranted;

    if (!granted) return;

    final info = await FilePickerWritable().openFile((info, file) async {
      if (await file.exists()) {
        await AppDatabase.importDB(file, (Map map) async {
          final date =
              DateTime.fromMillisecondsSinceEpoch(map['creation_date']);
          final itemsCount = map['stores'][0]['keys'].length;
          final reviewsCount = map['stores'][1]['keys'].length;

          return await showConfirmDialog(
            context,
            message: '${S.of(context).dialog_backup_msg}\n'
                '\n${Date.format(date, full: true, time: true)}\n'
                '\nItems: $itemsCount\nReviews: $reviewsCount',
            buttonText: S.of(context).button_restore,
          );
        });
      }

      return info;
    });

    if (info == null) {
      // TODO: Handle Error
    }
  }

  Future<void> _onChangeBackupPath() async {
    final granted = await Permission.storage.request().isGranted;

    if (!granted) return;

    //   await store.dispatch(setBackupPathAction(path.paths.first))
  }

  @override
  Widget build(BuildContext context) {
    // final store = StoreProvider.of<AppState>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.of(context).settings_backup,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffff7e65),
                ),
          ),
        ),
        ListTile(
          title: Text(S.of(context).settings_createbackup),
          subtitle: Text(S.of(context).settings_createbackup_descr),
          onTap: _createBackup,
        ),
        ListTile(
          title: Text(S.of(context).settings_restorebackup),
          subtitle: Text(S.of(context).settings_restorebackup_descr),
          onTap: () => _restoreBackup(context),
        ),
        Divider(height: 0),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.of(context).settings_automaticbackups,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffff7e65),
            ),
          ),
        ),
        ListTile(
          title: Text(S.of(context).settings_backupfreq),
          subtitle: Text('Everyday'),
        ),
        ListTile(
          title: Text(S.of(context).settings_backuplocation),
          subtitle: FutureBuilder<String>(
            future: _backupPath,
            builder: (context, snapshot) => Text(snapshot?.data ?? ''),
          ),
          onTap: _onChangeBackupPath,
        ),
      ],
    );
  }
}
