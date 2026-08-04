import 'package:flutter_test/flutter_test.dart';
import 'package:yande/model/tag_model.dart';

void main() {
  group('TagModel', () {
    test('collect_status roundtrip includes block', () {
      final tag = TagModel(1, 'solo', null, null, null)
        ..collectStatus = TagCollectStatus.block;
      final json = tag.toJson();
      expect(json['collect_status'], 2);
      final decoded = TagModel.fromJson(json);
      expect(decoded.collectStatus, TagCollectStatus.block);
    });

    test('fromTagString builds model with name', () {
      final tag = TagModel.fromTagString('long_hair');
      expect(tag.name, 'long_hair');
      expect(tag.collectStatus, isNull);
    });
  });
}