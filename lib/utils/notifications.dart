import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/database/review_dao.dart';
import 'package:jap_vocab/redux/state/settings_state.dart';

class Notifications {
  static final Notifications _singleton = Notifications._();
  static Notifications get instance => _singleton;
  Notifications._();

  FlutterLocalNotificationsPlugin _notificationsPlugin;

  Future<void> initNotifications() async {
    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    final androidSettings = AndroidInitializationSettings('app_icon');
    final settings = InitializationSettings(androidSettings, null);

    await _notificationsPlugin.initialize(
      settings,
      onSelectNotification: (String payload) async {},
    );

    await _notificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if (value.didNotificationLaunchApp) {
        //  _notificationsPlugin.cancelAll();
      }
    });
  }

  Future<void> exampleNotification() async {
    final androidDetails = AndroidNotificationDetails(
      'examples',
      'Examples',
      '',
      importance: Importance.Max,
      icon: 'notification_icon',
      channelShowBadge: true,
    );
    final details = NotificationDetails(androidDetails, null);

    await _notificationsPlugin.showWeeklyAtDayAndTime(
        1, '例えば...', 'いくつかの例を書いてください。', Day.Tuesday, Time(16, 00), details,
        payload: 'examples');
  }

  Future<void> reviewNotification(
    Remainder remainder, {
    Function(List<Review>) cb,
  }) async {
    final time = remainder.time;
    final days = remainder.days;
    final enabled = remainder.enabled;

    if (!enabled) return;

    final reviews = await ReviewDao().getAllReviews(filter: ReviewsFilter.NEXT);
    final count = reviews.length;

    final androidDetails = AndroidNotificationDetails(
      'reviews',
      'Reviews',
      '',
      importance: Importance.Max,
      icon: 'notification_icon',
      channelShowBadge: true,
    );
    final details = NotificationDetails(androidDetails, null);

    for (var i = 0; i < days.length; i++) {
      final day = days[i];
      await _notificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'レビュー時間',
        'レビューする$countの新しい語彙。',
        day,
        time,
        details,
        payload: 'reviews',
      );
    }
  }
}
