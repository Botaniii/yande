import 'package:dio/dio.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/http/yande/constant/api.dart';
import 'package:yande/model/tag_model.dart';

class TagApi {
  final YandeImageHttpDataSource source;

  TagApi(this.source);

  Future<List<TagModel>> getTagByNameOrderAESC(String name) async {
    final dio = Dio();
    final url = '${YandeApi.tag}?limit=40&order=count&name=$name';
    final res = await dio.get<List<dynamic>>(url);
    return res.data!
        .map((item) =>
            TagModel.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }
}