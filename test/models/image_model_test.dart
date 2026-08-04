import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/image_model.dart';

void main() {
  group('ImageModel', () {
    test('fromJson/toJson roundtrip statuses as ints', () {
      final image = ImageModel.fromJson({
        'id': 42,
        'tags': 'a b',
        'rating': 's',
        'collect_status': 1,
        'download_status': 2,
        'download_path': '/tmp/42.jpg',
      });
      expect(image.id, 42);
      expect(image.collectStatus, ImageCollectStatus.unStar);
      expect(image.downloadStatus, ImageDownloadStatus.success);

      final json = image.toJson();
      expect(json['collect_status'], 1);
      expect(json['download_status'], 2);
      expect(json['download_path'], '/tmp/42.jpg');
    });

    test('missing statuses default to null', () {
      final image = ImageModel.fromJson({'id': 1});
      expect(image.collectStatus, isNull);
      expect(image.downloadStatus, isNull);
      expect(image.isCollect(), isFalse);
    });

    test('setStatusByImage merges collected status', () {
      final remote = ImageModel.fromJson({'id': 1, 'rating': 'q'});
      final local = ImageModel.fromJson({
        'id': 1,
        'collect_status': 0,
        'download_status': 2,
        'download_path': '/data/1.jpg',
      });
      remote.setStatusByImage(local);
      expect(remote.collectStatus, ImageCollectStatus.star);
      expect(remote.downloadStatus, ImageDownloadStatus.success);
      expect(remote.downloadPath, '/data/1.jpg');
    });
  });
}