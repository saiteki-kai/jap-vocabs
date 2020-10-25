import 'package:flutter/material.dart';
import 'package:jap_vocab/models/item.dart';
import 'package:jap_vocab/pages/details/components/review_info.dart';

class ReviewsTab extends StatelessWidget {
  final Item item;
  const ReviewsTab({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReviewInfo(review: item.review1),
            SizedBox(height: 32.0),
            ReviewInfo(review: item.review2),
          ],
        ),
      ),
    );
  }
}
