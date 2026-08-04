import 'package:dio/dio.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/http/yande/constant/api.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';

class YandeImageListApi {
  final YandeImageHttpDataSource source;

  YandeImageListApi(this.source);

  AppDaoDataSource get _daoDataSource {
    return Application.getInstance().dataPool
        .getSource(DaoDataSource.name) as AppDaoDataSource;
  }

  Future<ImageModel?> fetchImageById(String id) async {
    final url = '${YandeApi.post}?tags=id:$id&limit=1';
    final res = await source.http.get<List<dynamic>>(url);
    final list = convertMapToImageModel(res);
    return list.isEmpty ? null : list.first;
  }

  Future<List<ImageModel>> fetchImageByPage(int page, int limit) async {
    final url = '${YandeApi.post}?page=$page&limit=$limit';
    final res = await source.http.get<List<dynamic>>(url);
    return _decorate(res, page);
  }

  Future<List<ImageModel>> getIndexListByTags(
    String tags,
    int pages,
    int limit,
  ) async {
    final url = '${YandeApi.post}?tags=$tags&page=$pages&limit=$limit';
    final res = await source.http.get<List<dynamic>>(url);
    return _decorate(res, pages);
  }

  /// 合并本地收藏/下载状态，并解析 tags 字符串。
  Future<List<ImageModel>> _decorate(
      Response<List<dynamic>> res, int page) async {
    final list = convertMapToImageModel(res);
    final trueList = <ImageModel>[];
    for (final item in list) {
      if (item.tags != null) {
        item.tagTagModelList = convertTagStringToList(item.tags!);
      }
      final dto = await _daoDataSource.fetchImageById(item.id ?? -1);
      if (dto != null) {
        item.setStatusByImage(dto);
      }
      item.dataSourceName = source.sourceName;
      item.pages = page;
      trueList.add(item);
    }
    return trueList;
  }

  List<ImageModel> convertMapToImageModel(Response<List<dynamic>> res) {
    return res.data!
        .map((item) =>
            ImageModel.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  List<TagModel> convertTagStringToList(String tags) {
    return tags.split(' ').map(TagModel.fromTagString).toList();
  }
}