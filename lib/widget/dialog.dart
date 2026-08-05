import 'package:flutter/material.dart';
import 'package:yande/model/github_model.dart';
import 'package:yande/service/updateService.dart';
import 'package:yande/utils/apkInstaller.dart';

class UpdateDialog extends StatefulWidget {
  final GithubReleaseModel release;

  const UpdateDialog({super.key, required this.release});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  bool _downloading = false;
  double _progress = 0;
  String? _error;

  GithubReleaseModel get release => widget.release;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新版本已经发布'),
      content: _buildContent(),
      actions: _buildActions(),
    );
  }

  Widget _buildContent() {
    if (_error != null) {
      return Text(_error!, style: const TextStyle(color: Colors.red));
    }
    if (_downloading) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          LinearProgressIndicator(value: _progress <= 0 ? null : _progress),
          const SizedBox(height: 10),
          Text(
            '正在下载 ${release.tagName}...'
            '${(_progress * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 13),
          ),
        ],
      );
    }
    return Text(release.body ?? '');
  }

  List<Widget> _buildActions() {
    return <Widget>[
      TextButton(
        onPressed: _downloading ? null : _ignoreVersion,
        child: const Text('忽略此版本'),
      ),
      TextButton(
        onPressed: _downloading ? null : () => Navigator.pop(context),
        child: const Text('暂时不'),
      ),
      TextButton(
        onPressed: _downloading ? null : _startDownload,
        child: const Text('更新'),
      ),
    ];
  }

  void _ignoreVersion() {
    UpdateService.ignoreUpdateVersion(release.tagName ?? '');
    Navigator.pop(context);
  }

  Future<void> _startDownload() async {
    setState(() {
      _downloading = true;
      _error = null;
      _progress = 0;
    });
    try {
      await UpdateService.downloadAndInstall(
        release,
        onProcess: (received, total) {
          if (total > 0 && mounted) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } on InstallPermissionException {
      if (mounted) {
        setState(() {
          _downloading = false;
          _error = '需要开启“安装未知应用”权限才能继续';
        });
      }
      await ApkInstaller.openInstallSettings();
    } catch (_) {
      if (mounted) {
        setState(() {
          _downloading = false;
          _error = '下载失败，请稍后再试';
        });
      }
    }
  }
}