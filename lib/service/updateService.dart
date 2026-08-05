import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yande/http/all_api.dart';
import 'package:yande/model/github_model.dart';
import 'package:yande/service/settingService.dart';

typedef ShouldUpdateCallback = void Function(GithubReleaseModel);

class UpdateService {
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
        packageInfo.version != githubReleaseModel.tagName?.replaceFirst("v", "")) {
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