
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/http/yande/YandeHttpDataSource.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/service/settingService.dart';

class Application {
  static Application? _instance;

  static Application getInstance() {
    final instance = _instance;
    if (instance == null) {
      throw StateError(
          'Application.init() must be awaited before getInstance()');
    }
    return instance;
  }

  static Future<void> init() async {
    if (_instance != null) return;
    final app = Application._();
    _instance = app;
    await app._bootstrap();
  }

  final Dio _dio;
  String? filterRank;
  late final _AppDataSourcePool dataPool;

  Application._()
      : _dio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
        )) {
    dataPool = _AppDataSourcePool();
    dataPool.registryDataSource(YandeImageHttpDataSource(_dio));
    dataPool.registryDataSource(DaoDataSource());
  }

  Future<void> _bootstrap() async {
    await SettingService.initSetting();
    await getFilterRank();
  }

  Future<void> getFilterRank() async {
    final filterRankItem =
        await SettingService.getSetting(SETTING_TYPE.FILTER_RANK);
    filterRank = filterRankItem.value;
  }

  Future<void> setFilterRank(SettingItem item) async {
    await SettingService.saveSetting(item);
    filterRank = item.value;
  }
}

abstract class AppDataSource {
  String get sourceName;

  Future<List<ImageModel>> fetchImageByPage(int page, int limit);
  Future<ImageModel?> fetchImageById(int id);
  Future<List<ImageModel>> fetchImageByTag(String tag, int page, int limit);
}

abstract class AppHttpDataSource extends AppDataSource {
  Dio get http;
  Future<List<TagModel>> searchTag(String words);
}

abstract class AppDaoDataSource extends AppDataSource {
  Future<Database> getDatabase();
  Future<bool> isImageExistById(int id);
  Future<void> updateDownloadImageStatus(ImageModel image);
  Future<void> collectImage(ImageModel image);
  Future<List<ImageModel>> getAllCollectedImage();
  Future<void> saveTag(TagModel tag);
  Future<List<TagModel>> getAllCollectTag();
  Future<List<TagModel>> getAllBlockTag();
}

class _AppDataSourcePool {
  final Map<String, AppDataSource> _pool = <String, AppDataSource>{};
  AppDataSource? _activeSource;

  AppDataSource getSource([String? name]) {
    if (name == null) {
      final active = _activeSource;
      if (active == null) {
        throw StateError('No active data source');
      }
      return active;
    }
    final source = _pool[name];
    if (source == null) {
      throw StateError('No data source named "$name"');
    }
    return source;
  }

  List<String> getAllHttpSourceNameList() {
    final keys = _pool.keys.toList();
    keys.removeWhere((value) => value == DaoDataSource.name);
    return keys;
  }

  void switchHttpSource(String name) {
    final source = _pool[name];
    if (source == null) {
      throw StateError('No data source named "$name"');
    }
    _activeSource = source;
  }

  void removeHttpSource(String name) {
    _pool.remove(name);
  }

  String getActiveSourceName() {
    return _activeSource!.sourceName;
  }

  void registryDataSource(AppDataSource source) {
    _pool[source.sourceName] = source;
    _activeSource ??= source;
  }
}
