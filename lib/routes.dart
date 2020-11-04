import 'package:flutter/material.dart';
import 'package:jap_vocab/models/answer.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/models/review.dart';
import 'package:jap_vocab/pages/add/add.dart';
import 'package:jap_vocab/pages/details/details.dart';
import 'package:jap_vocab/pages/favorites/favorites.dart';
import 'package:jap_vocab/pages/home/home.dart';
import 'package:jap_vocab/pages/reviews/reviews.dart';
import 'package:jap_vocab/pages/settings/settings.dart';
import 'package:jap_vocab/pages/summary/summary.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Map args = settings.arguments;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomePage());
    case '/add':
      return MaterialPageRoute(builder: (_) => AddPage());
    case '/edit':
      final item = args['item'] as Item;
      return MaterialPageRoute(builder: (_) => AddPage(item: item));
    case '/details':
      final id = args['id'] as String;
      return MaterialPageRoute(builder: (_) => DetailsPage(id: id));
    case '/reviews':
      final reviews = args['reviews'] as List<Review>;
      return MaterialPageRoute(builder: (_) => ReviewPage(reviews: reviews));
    case '/summary':
      final answers = args['answers'] as List<Answer>;
      return MaterialPageRoute(builder: (_) => SummaryPage(answers: answers));
    case '/favorites':
      return MaterialPageRoute(builder: (_) => FavoritesPage());
    case '/settings':
      return MaterialPageRoute(builder: (_) => SettingsPage());
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        },
      );
  }
}
