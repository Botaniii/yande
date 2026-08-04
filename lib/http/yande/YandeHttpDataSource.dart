import 'package:dio/dio.dart';
import 'package:yande/appliction.dart';
import 'package:yande/http/yande/constant/api.dart';
import 'package:yande/http/yande/imageListApi.dart';
import 'package:yande/http/yande/tagApi.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';

class YandeImageHttpDataSource implements AppHttpDataSource {
  @override
  final String sourceName = YandeApi.sourceName;

  @override
  final Dio http;
  late final YandeImageListApi _imageListApi;
  late final TagApi _tagApi;

  YandeImageHttpDataSource(this.http) {
    _imageListApi = YandeImageListApi(this);
    _tagApi = TagApi(this);
  }

  @override
  Future<ImageModel?> fetchImageById(int id) {
    return _imageListApi.fetchImageById('$id');
  }

  @override
  Future<List<ImageModel>> fetchImageByPage(int page, int limit) {
    return _imageListApi.fetchImageByPage(page, limit);
  }

  @override
  Future<List<TagModel>> searchTag(String words) {
    return _tagApi.getTagByNameOrderAESC(words);
  }

  @override
  Future<List<ImageModel>> fetchImageByTag(String tag, int page, int limit) {
    return _imageListApi.getIndexListByTags(tag, page, limit);
  }
}