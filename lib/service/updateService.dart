import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yande/http/all_api.dart';
import 'package:yande/model/github_model.dart';
import 'package:yande/service/settingService.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yande/utils/apkInstaller.dart';

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
    void Function()? onUpToDate,
  }) async {
    final dio = Dio();
    final res = await dio.get<dynamic>(GithubApi.latestApi);
    final githubReleaseModel = GithubReleaseModel.fromJson(
      Map<String, dynamic>.from(res.data as Map),
    );
    final packageInfo = await PackageInfo.fromPlatform();
    final item = await SettingService.getSetting(UpdateValue.ignoreVersion);

    final hasUpdate = _isNewerVersion(githubReleaseModel.tagName ?? '', packageInfo.version);
    if (!hasUpdate) {
      onUpToDate?.call();
    } else if (githubReleaseModel.tagName != item.value) {
      shouldUpdate?.call(githubReleaseModel);
    }
    // 已忽略该版本时静默：不弹窗也不提示已是最新。
  }

  /// ?? release ? APK ??????????
  static String? _abiSuffix(String abi) {
    switch (abi) {
      case 'arm64-v8a':
        return 'arm64';
      case 'armeabi-v7a':
        return 'armv7';
      case 'x86_64':
        return 'x86_64';
      case 'x86':
        return 'x86';
      default:
        return null;
    }
  }

  static Future<void> downloadAndInstall(
    GithubReleaseModel release, {
    ProgressCallback? onProcess,
  }) async {
    final tag = release.tagName ?? '';
    final abi = await ApkInstaller.primaryAbi();
    final suffix = _abiSuffix(abi);
    final assets = release.assets ?? <GithubAssets>[];

    GithubAssets? pick(String s) {
      for (final asset in assets) {
        if ((asset.name ?? '') == 'yande-$tag-$s.apk') {
          return asset;
        }
      }
      return null;
    }

    var apkAsset = suffix != null ? pick(suffix) : null;
    apkAsset ??= pick('universal');
    if (apkAsset == null) {
      for (final asset in assets) {
        if ((asset.name ?? '').endsWith('.apk')) {
          apkAsset = asset;
          break;
        }
      }
    }
    final apkUrl = apkAsset?.browserDownloadUrl;
    if (apkUrl == null) {
      throw StateError('release has no apk asset');
    }

    final dir = await getApplicationSupportDirectory();
    final apkDir = Directory('${dir.path}/apk');
    await apkDir.create(recursive: true);
    final target = '${apkDir.path}/yande-${release.tagName}.apk';
    if (!await File(target).exists()) {
      await Dio().download(apkUrl, target, onReceiveProgress: onProcess);
    }

    if (!await ApkInstaller.canRequestInstall()) {
      throw const InstallPermissionException();
    }
    await ApkInstaller.install(target);
  }


  static Future<void> ignoreUpdateVersion(String version) async {
    await SettingService.saveSetting(
      SettingItem(name: UpdateValue.ignoreVersion, value: version),
    );
  }
}

class InstallPermissionException implements Exception {
  const InstallPermissionException();
}


class UpdateValue {
  static const String ignoreVersion = 'ignoreVersion';
}