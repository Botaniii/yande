import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:yande/utils/utils.dart';

/// 外部存储根（公共目录），多数 Android 设备固定路径。
const String _externalRoot = '/storage/emulated/0';

class DirectoryPickerView extends StatefulWidget {
  final String path;

  DirectoryPickerView(this.path, {super.key}) : assert(path.isNotEmpty);

  @override
  State<StatefulWidget> createState() => _DirectoryPickerView();
}

class _DirectoryPickerView extends State<DirectoryPickerView> {
  bool isLoading = true;
  String? loadError;
  List<MyDirectoryStat> dirList = <MyDirectoryStat>[];
  Directory? currentDir;
  String rootPath = _externalRoot;

  @override
  void initState() {
    super.initState();
    _initStartPath();
  }

  Future<void> _initStartPath() async {
    // 优先从公共存储根开始浏览；不可用时回退到应用文档目录。
    final externalExists = await Directory(_externalRoot).exists();
    rootPath = externalExists
        ? _externalRoot
        : (await getApplicationDocumentsDirectory()).path;

    var start = widget.path;
    if (!(await Directory(start).exists())) {
      start = rootPath;
    }
    await getDirList(start);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('选择文件夹'),
      ),
      body: Column(
        children: <Widget>[
          _buildDirPathHeader(),
          _buildQuickAccessBar(),
          Expanded(child: _buildDirList()),
        ],
      ),
      bottomNavigationBar: _buildConfirmBottomButton(context),
    );
  }

  Widget _buildDirList() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: <Widget>[
        if (loadError != null)
          Container(
            width: double.infinity,
            color: const Color(0xFFFFF3E0),
            padding: const EdgeInsets.all(8),
            child: Text(
              loadError!,
              style: const TextStyle(color: Color(0xFFB26A00), fontSize: 13),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: dirList.length + (_canGoUp() ? 1 : 0),
            itemBuilder: (context, index) {
              if (_canGoUp() && index == 0) {
                return ListTile(
                  leading: const Icon(Icons.folder_open),
                  title: const Text('...（上一级）'),
                  onTap: () {
                    if (currentDir != null && currentDir!.path != '/') {
                      getDirList(currentDir!.parent.path);
                    }
                  },
                );
              }
              final d = dirList[index - (_canGoUp() ? 1 : 0)];
              return ListTile(
                leading: const Icon(
                  Icons.folder,
                  color: Color(0xFFFFB300),
                ),
                title: Text(basename(d.path)),
                onTap: () {
                  getDirList(d.path);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// 快捷入口：常用公共目录 + 应用私有目录。
  Widget _buildQuickAccessBar() {
    return FutureBuilder<List<_QuickAccessItem>>(
      future: _loadQuickAccess(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? const <_QuickAccessItem>[];
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ActionChip(
                    label: Text(
                      item.label,
                      style: const TextStyle(fontSize: 13),
                    ),
                    onPressed: () {
                      getDirList(item.path);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<List<_QuickAccessItem>> _loadQuickAccess() async {
    final appDir = await getApplicationDocumentsDirectory();
    final candidates = <_QuickAccessItem>[
      _QuickAccessItem('下载', '$_externalRoot/Download'),
      _QuickAccessItem('图片', '$_externalRoot/Pictures'),
      _QuickAccessItem('相机', '$_externalRoot/DCIM'),
      _QuickAccessItem('音乐', '$_externalRoot/Music'),
      _QuickAccessItem('视频', '$_externalRoot/Movies'),
      _QuickAccessItem('存储根', _externalRoot),
      _QuickAccessItem('应用目录', appDir.path),
    ];
    final result = <_QuickAccessItem>[];
    for (final item in candidates) {
      if (await Directory(item.path).exists()) {
        result.add(item);
      }
    }
    return result;
  }

  bool _canGoUp() {
    if (currentDir == null) {
      return false;
    }
    final p = currentDir!.path;
    return p != '/' && p != rootPath;
  }

  Future<void> getDirList(String path) async {
    isLoading = true;
    loadError = null;
    if (mounted) {
      setState(() {});
    }

    currentDir = Directory(path);
    try {
      dirList = await FileUtils.getAllDirectoryChildren(currentDir!);
    } catch (e) {
      // 无权限或 SELinux 拦截时优雅降级，不卡死页面。
      dirList = <MyDirectoryStat>[];
      loadError = '无法访问此目录（可能没有权限）';
    }

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildDirPathHeader() {
    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Color(0xffeff0f1),
        border: Border(
          bottom: BorderSide(color: Color(0xffdddddd)),
        ),
      ),
      child: Text(
        currentDir?.path ?? '',
        style: const TextStyle(fontSize: 13),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildConfirmBottomButton(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xffdddddd)),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, currentDir?.path);
              },
              child: const Text('选择此文件夹'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('取消'),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessItem {
  final String label;
  final String path;

  const _QuickAccessItem(this.label, this.path);
}