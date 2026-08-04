import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  static final List<SettingItem<String>> settingList = [
    SettingItem(
      name: SETTING_TYPE.IMAGE_DOWNLOAD_PATH,
      value: '',
    ),
    SettingItem(
      name: SETTING_TYPE.FILTER_RANK,
      value: FILTER_RANK.NORMAL,
    ),
  ];

  static Future<void> initSetting([bool? force]) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('initSetting') != true || force == true) {
      for (final item in settingList) {
        if (item.name == SETTING_TYPE.IMAGE_DOWNLOAD_PATH) {
          final appDocDir = await getApplicationDocumentsDirectory();
          final yandeImageDir = Directory('${appDocDir.path}/yandeImage');
          if (!await yandeImageDir.exists()) {
            await yandeImageDir.create(recursive: true);
          }
          item.value = yandeImageDir.path;
          await saveSetting(item);
        } else if (item.name == SETTING_TYPE.FILTER_RANK) {
          await saveSetting(item);
        }
      }
      await prefs.setBool('initSetting', true);
    } else {
      await getAllSetting();
    }
  }

  static Future<void> saveSetting(SettingItem settingItem) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(settingItem.name, settingItem.value);
  }

  static Future<SettingItem<String>> getSetting(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(name);
    String? defaultValue;
    for (final item in settingList) {
      if (item.name == name) {
        defaultValue = item.value;
        break;
      }
    }
    return SettingItem<String>(
        name: name, value: value ?? defaultValue ?? '');
  }

  static Future<List<SettingItem<String>>> getAllSetting() async {
    final prefs = await SharedPreferences.getInstance();
    for (final item in settingList) {
      item.value = prefs.getString(item.name) ?? item.value;
    }
    return settingList;
  }
}

// ignore: camel_case_types
class SETTING_TYPE {
  static const String IMAGE_DOWNLOAD_PATH = '图片下载路径';
  static const String FILTER_RANK = '过滤等级';
}

// ignore: camel_case_types
class FILTER_RANK {
  static const String NORMAL = 's';
  static const String NOT_RESTRICTED = 'q';
  static const String RESTRICTED = 'e';
}

class SettingItem<T> {
  String name;
  T value;

  SettingItem({required this.name, required this.value});
}