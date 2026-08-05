import 'package:flutter/material.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/store/store.dart';
import 'package:yande/view/collectView/collectImageView.dart';
import 'package:yande/view/download/downloadManageView.dart';
import 'package:yande/view/search/resultView.dart';
import 'package:yande/view/setting/settingView.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountEmail: Text(''),
            accountName: Text('yande'),
          ),
          MediaQuery.removePadding(
            context: context,
            child: Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: const Text('收藏'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, CollectImageView.route);
                    },
                  ),
                  ListTile(
                    title: const Text('下载管理'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, DownloadManageView.route);
                    },
                  ),
                  ListTile(
                    title: const Text('设置'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, SettingView.route);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RightDrawer extends StatefulWidget {
  const RightDrawer({super.key});

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> {
  List<TagModel> shortcutList = <TagModel>[];

  @override
  void initState() {
    super.initState();
    getShortcutList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            _buildShortcutDrawerHeader(),
            Expanded(
              child: _buildShortcutList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutList() {
    return ListView(
      children: shortcutList
          .map(
            (tag) => ListTile(
              title: Text(tag.name ?? ''),
              onTap: () {
                _goResultView(tag.name ?? '');
              },
            ),
          )
          .toList(),
    );
  }

  void getShortcutList() {
    shortcutList = TagStore.shortCutList;
  }

  _buildShortcutDrawerHeader({GestureTapCallback? onPressed}) {
    return Container(
      color: const Color(0xffeff0f1),
      child: ListTile(
        title: const Text('快捷搜索'),
        trailing: FilledButton(
          onPressed: onPressed,
          child: const Icon(Icons.settings),
        ),
      ),
    );
  }

  _goResultView(String word) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return ResultView(
                tags: word,
              );
            }));
  }
}