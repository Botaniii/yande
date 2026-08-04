import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/imageServive.dart';

void main() {
  group('applyFilterRank', () {
    ImageModel imageWith(String rating) =>
        ImageModel.fromJson({'id': 1, 'rating': rating});

    test('RESTRICTED filter keeps everything', () {
      expect(applyFilterRank(imageWith('e'), 'e'), isFalse);
      expect(applyFilterRank(imageWith('q'), 'e'), isFalse);
      expect(applyFilterRank(imageWith('s'), 'e'), isFalse);
    });

    test('NOT_RESTRICTED filters out e only', () {
      expect(applyFilterRank(imageWith('e'), 'q'), isTrue);
      expect(applyFilterRank(imageWith('q'), 'q'), isFalse);
      expect(applyFilterRank(imageWith('s'), 'q'), isFalse);
    });

    test('NORMAL filters out e and q', () {
      expect(applyFilterRank(imageWith('e'), 's'), isTrue);
      expect(applyFilterRank(imageWith('q'), 's'), isTrue);
      expect(applyFilterRank(imageWith('s'), 's'), isFalse);
    });
  });
}