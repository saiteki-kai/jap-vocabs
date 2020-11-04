import 'package:jap_vocab/generated/l10n.dart';

String reviewType(context, type) {
  switch (type) {
    case 'writing':
      return S.of(context).item_writing;
    case 'reading':
      return S.of(context).item_reading;
    case 'meaning':
    default:
      return S.of(context).item_meaning;
  }
}
