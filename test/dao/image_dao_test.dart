import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';

void main() {
  late DaoDataSource source;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    source = DaoDataSource(
      databaseFactory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
    );
  });

  ImageModel sampleImage() => ImageModel.fromJson({
        'id': 7,
        'tags': 'solo long_hair',
        'author': 'someone',
        'file_url': 'http://example.com/file.jpg',
        'file_ext': 'jpg',
        'preview_url': 'http://example.com/preview.jpg',
        'rating': 's',
        'width': 100,
        'height': 200,
      });

  test('collect then fetch merges status', () async {
    final image = sampleImage()..collectStatus = ImageCollectStatus.star;
    await source.collectImage(image);

    final loaded = await source.fetchImageById(7);
    expect(loaded, isNotNull);
    expect(loaded!.id, 7);
    expect(loaded.collectStatus, ImageCollectStatus.star);
  });

  test('updateDownloadImageStatus persists path', () async {
    final image = sampleImage();
    await source.updateDownloadImageStatus(image);

    final updated = sampleImage()
      ..downloadStatus = ImageDownloadStatus.success
      ..downloadPath = '/data/7.jpg';
    await source.updateDownloadImageStatus(updated);

    final loaded = await source.fetchImageById(7);
    expect(loaded!.downloadStatus, ImageDownloadStatus.success);
    expect(loaded.downloadPath, '/data/7.jpg');
  });

  test('uncollected images are not returned', () async {
    final image = sampleImage()..collectStatus = ImageCollectStatus.unStar;
    await source.collectImage(image);
    final all = await source.getAllCollectedImage();
    expect(all, isEmpty);
  });
}