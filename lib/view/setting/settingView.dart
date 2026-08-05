import 'package:flutter/material.dart';
import 'package:yande/appliction.dart';
import 'package:yande/service/settingService.dart';
import 'package:yande/service/updateService.dart';
import 'package:yande/widget/dialog.dart';
import 'package:yande/widget/progress.dart';
import 'dart:async';

import 'subview/dirPickerView.dart';

class SettingView extends StatefulWidget {
  static const title = '设置';
  static const route = '/setting';

  const SettingView({super.key});

  @override
  State<StatefulWidget> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool initSuccess = false;
  List<SettingItem<String>>? settingList;

  final List<_DropButtonData> dropButtonDataList = [
    const _DropButtonData(name: '正常', value: 's'),
    const _DropButtonData(name: '擦边', value: 'q'),
    const _DropButtonData(name: '限制', value: 'e'),
  ];

  @override
  void initState() {
    super.initState();
    getAllSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('设置'),
      ),
      body: _buildSettingList(),
    );
  }

  _buildSettingList() {
    if (initSuccess) {
      return ListView(
        children: <Widget>[
          ...(settingList ?? <SettingItem<String>>[])
              .map((v) => _buildSettingItem(v)),
          _buildCheckUpdateItem(),
        ],
      );
    } else {
      return const Center(
        child: CenterProgress(),
      );
    }
  }

  Future<void> getAllSetting() async {
    settingList = await SettingService.getAllSetting();
    initSuccess = true;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildSettingItem(SettingItem v) {
    if (v.name == SETTING_TYPE.IMAGE_DOWNLOAD_PATH) {
      return ListTile(
        title: Text(v.name),
        subtitle: Text('${v.value}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final path = await Navigator.push(context,
              MaterialPageRoute(builder: (c) {
            return DirectoryPickerView('${v.value}');
          }));
          if (path != null) {
            _handlePickedName(v, path as String);
          }
        },
      );
    } else if (v.name == SETTING_TYPE.FILTER_RANK) {
      return ListTile(
        title: Text(v.name),
        subtitle: Text(getRankNameByValue('${v.value}')),
        trailing: DropdownButton<String>(
          value: v.value as String,
          onChanged: (String? newValue) {
            if (newValue == null) return;
            v.value = newValue;
            Application.getInstance().setFilterRank(v as SettingItem<String>);
            _showMessageBySnackbar('过滤等级更新成功，刷新之后生效');
            if (mounted) {
              setState(() {});
            }
          },
          items: dropButtonDataList.map((_DropButtonData data) {
            return DropdownMenuItem<String>(
              value: data.value,
              child: Text(data.name),
            );
          }).toList(),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildCheckUpdateItem() {
    return ListTile(
      title: const Text('????'),
      subtitle: const Text('?? GitHub ???????'),
      trailing: const Icon(Icons.system_update_alt),
      onTap: _checkUpdate,
    );
  }

  void _checkUpdate() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('???????'),
        duration: Duration(seconds: 2),
      ),
    );
    try {
      await UpdateService.getVersion(
        shouldUpdate: (githubRelease) {
          if (mounted) {
            showDialog(
              context: context,
              builder: (context) => UpdateDialog(
                version: githubRelease.tagName,
                text: githubRelease.body,
                url: githubRelease.htmlUrl,
              ),
            );
          }
        },
        onUpToDate: () {
          if (mounted) {
            _showMessageBySnackbar('??????');
          }
        },
      );
    } catch (_) {
      if (mounted) {
        _showMessageBySnackbar('????????????');
      }
    }
  }

  String getRankNameByValue(String val) {
    for (final data in dropButtonDataList) {
      if (data.value == val) {
        return data.name;
      }
    }
    return val;
  }

  FutureOr _handlePickedName(SettingItem item, String path) async {
    item.value = path;
    await SettingService.saveSetting(item as SettingItem<String>);
    if (mounted) {
      setState(() {});
    }
  }

  _showMessageBySnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _DropButtonData {
  final String name;
  final String value;

  const _DropButtonData({required this.name, required this.value});
}