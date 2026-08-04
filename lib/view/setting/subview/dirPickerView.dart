import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:yande/utils/utils.dart';
import 'package:yande/widget/progress.dart';

class DirectoryPickerView extends StatefulWidget {
  final String path;

  DirectoryPickerView(this.path, {super.key}) : assert(path.isNotEmpty);

  @override
  State<StatefulWidget> createState() => _DirectoryPickerView();
}

class _DirectoryPickerView extends State<DirectoryPickerView> {
  bool isLoading = true;
  List<MyDirectoryStat> dirList = <MyDirectoryStat>[];
  Directory? currentDir;
  String rootPath = '';

  @override
  void initState() {
    super.initState();
    getRootPath();
    getDirList(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('选择文件夹'),
      ),
      body: _buildDirList(),
      bottomNavigationBar: _buildConfirmBottomButton(context),
    );
  }

  Widget _buildDirList() {
    if (isLoading) {
      return Column(
        children: <Widget>[
          _buildDirPathHeader(),
          const Expanded(
            child: Center(
              child: CenterProgress(),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          _buildDirPathHeader(),
          Expanded(
            child: ListView(
              children: _buildDirListTile(dirList),
            ),
          ),
        ],
      );
    }
  }

  Future<void> getDirList(String path) async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }

    currentDir = Directory(path);
    dirList = await FileUtils.getAllDirectoryChildren(Directory(path));

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  List<Widget> _buildDirListTile(List<MyDirectoryStat> dirList) {
    final listTiles = <Widget>[];
    if (currentDir != null && currentDir!.path != rootPath) {
      listTiles.add(ListTile(
        leading: const Icon(Icons.folder_open),
        title: const Text('...'),
        onTap: () {
          getDirList(currentDir!.parent.path);
        },
      ));
    }
    listTiles.addAll(
      dirList.map(
        (d) => ListTile(
          leading: const Icon(
            Icons.folder,
            color: Colors.amberAccent,
          ),
          title: Text(basename(d.path)),
          onTap: () {
            getDirList(d.path);
          },
        ),
      ),
    );
    return listTiles;
  }

  Future<void> getRootPath() async {
    rootPath = (await getApplicationDocumentsDirectory()).path;
  }

  Widget _buildDirPathHeader() {
    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Color(0xffeff0f1),
        border: Border(
          bottom: BorderSide(color: Color(0xffcccccc)),
        ),
      ),
      child: Text(currentDir?.path ?? ''),
    );
  }

  _buildConfirmBottomButton(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xffcccccc)),
        ),
      ),
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          NormalButton(
            '选择',
            onTap: () {
              Navigator.pop(context, currentDir?.path);
            },
          ),
          NormalButton(
            '取消',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class NormalButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;

  const NormalButton(this.text, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}