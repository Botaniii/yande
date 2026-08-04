import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/widget/imageGrid/imageCard.dart';

void main() {
  testWidgets('MainImageCard renders size and star, taps image', (
    tester,
  ) async {
    final image = ImageModel.fromJson({
      'id': 1,
      'width': 100,
      'height': 200,
      'preview_url': 'http://example.com/p.jpg',
      'collect_status': 0,
    });
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MainImageCard(
            image,
            imageBuilder: (_) => const SizedBox.expand(child: ColoredBox(color: Colors.grey)),
            imageTap: (_) => tapped = true,
            collectEvent: () {},
            downloadEvent: () {},
            heroPrefix: 'test',
          ),
        ),
      ),
    );

    expect(find.text('100 x 200'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.tap(find.byType(GestureDetector).first);
    expect(tapped, isTrue);
  });
}