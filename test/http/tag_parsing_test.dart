import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/http/yande/imageListApi.dart';

void main() {
  group('convertTagStringToList', () {
    test('splits space separated tags', () {
      final api = YandeImageListApi(YandeImageHttpDataSource(Dio()));
      final tags = api.convertTagStringToList('solo long_hair blue_eyes');
      expect(tags.map((t) => t.name), ['solo', 'long_hair', 'blue_eyes']);
    });
  });
}