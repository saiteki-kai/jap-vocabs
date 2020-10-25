import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/database/item_dao.dart';
import 'package:jap_vocab/database/review_dao.dart';
import 'package:uuid/uuid.dart';

void insertItem(Item item, bool kanji) async {
  final reviewDao = ReviewDao();
  final itemDao = ItemDao();

  final uuid = Uuid();
  var itemId = uuid.v1();
  var reviewId1 = uuid.v1();
  var reviewId2 = uuid.v1();

  await reviewDao.insertReview(
    Review(
      id: reviewId1,
      itemId: itemId,
      reviewType: 'meaning',
      type: kanji ? 'kanji' : 'word',
    ),
  );

  await reviewDao.insertReview(
    Review(
      id: reviewId2,
      itemId: itemId,
      reviewType: item.type == 'kanji' ? 'writing' : 'reading',
      type: kanji ? 'kanji' : 'word',
    ),
  );

  await itemDao.insertItem(item.copyWith(
    id: itemId,
    reviewId1: reviewId1,
    reviewId2: reviewId2,
  ));
}

final item1 = Item(
  text: '溶岩',
  meaning: 'lava',
  type: 'word',
  reading: 'ようがん',
);

final item2 = Item(
  text: '事実',
  meaning: 'fatto, realtà',
  type: 'word',
  reading: 'じじつ',
);

final item3 = Item(
  text: '空',
  meaning: 'cielo, vuoto, vacante',
  type: 'kanji',
);

final item4 = Item(
  text: '紙',
  meaning: 'carta',
  type: 'word',
  reading: 'かみ',
);

final item5 = Item(
  text: '金',
  meaning: 'soldi, denaro',
  type: 'word',
  reading: 'かね',
);

final item6 = Item(
  text: '黙り',
  meaning: 'silenzio',
  type: 'word',
  reading: 'だんまり',
);

final item7 = Item(
  text: '雷雨',
  meaning: 'tempesta',
  type: 'word',
  reading: 'らいう',
);

void insertItems() {
//  insertItem(item1, false);
//  insertItem(item2, false);
//  insertItem(item3, true);
//  insertItem(item4, false);
//  insertItem(item5, false);
//  insertItem(item6, false);
//  insertItem(item7, false);
//  insertItem(
//      Item(
//        text: "伝",
//        meaning: "trasmettere, leggenda, tradizione, seguire",
//        type: "kanji",
//      ),
//      true);
//  insertItem(
//      Item(
//        text: "対",
//        meaning: "opposto, contro, anti-",
//        type: "kanji",
//      ),
//      true);
//  insertItem(
//      Item(
//        text: "改",
//        meaning: "rinnovare, riformare, cambiare, esaminare",
//        type: "kanji",
//      ),
//      true);

  insertItem(
      Item(
        text: '希望',
        meaning: 'speranza',
        type: 'word',
        reading: 'きぼう',
      ),
      false);
  insertItem(
      Item(
        text: '植物',
        meaning: 'pianta, vegetazione',
        type: 'word',
        reading: 'しょくぶつ',
      ),
      false);
  insertItem(
      Item(
        text: '植える',
        meaning: 'piantare, trapiantare, instillare',
        type: 'word',
        reading: 'うえる',
      ),
      false);
  insertItem(
      Item(
        text: '植',
        meaning: 'pianta',
        type: 'kanji',
      ),
      true);
}
