import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yande/http/all_api.dart';
import 'package:yande/model/github_model.dart';
import 'package:yande/service/settingService.dart';

typedef ShouldUpdateCallback = void Function(GithubReleaseModel);

class UpdateService {
  static bool _isNewerVersion(String remote, String current) {
    List<int> parse(String v) => v
        .replaceFirst('v', '')
        .split('.')
        .map((s) => int.tryParse(s.trim()) ?? 0)
        .toList();
    final r = parse(remote);
    final c = parse(current);
    final len = r.length > c.length ? r.length : c.length;
    for (var i = 0; i < len; i++) {
      final rv = i < r.length ? r[i] : 0;
      final cv = i < c.length ? c[i] : 0;
      if (rv != cv) {
        return rv > cv;
      }
    }
    return false;
  }
  static Future<void> getVersion({
    ShouldUpdateCallback? shouldUpdate,
  }) async {
    final dio = Dio();
    final res = await dio.get<dynamic>(GithubApi.latestApi);
    final githubReleaseModel = GithubReleaseModel.fromJson(
      Map<String, dynamic>.from(res.data as Map),
    );
    final packageInfo = await PackageInfo.fromPlatform();
    final item = await SettingService.getSetting(UpdateValue.ignoreVersion);

    if (githubReleaseModel.tagName != item.value &&
        _isNewerVersion(githubReleaseModel.tagName ?? '', packageInfo.version)) {
      shouldUpdate?.call(githubReleaseModel);
    }
  }

  static Future<void> ignoreUpdateVersion(String version) async {
    await SettingService.saveSetting(
      SettingItem(name: UpdateValue.ignoreVersion, value: version),
    );
  }
}

class UpdateValue {
  static const String ignoreVersion = 'ignoreVersion';
}