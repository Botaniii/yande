import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yande/service/updateService.dart';

class UpdateDialog extends StatelessWidget {
  final String? version;
  final String? text;
  final String? url;

  const UpdateDialog({super.key, this.version, this.text, this.url});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新版本已经发布'),
      content: Text(text ?? ''),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (version != null) {
              UpdateService.ignoreUpdateVersion(version!);
            }
            Navigator.pop(context);
          },
          child: const Text('忽略此版本'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('暂时不'),
        ),
        TextButton(
          onPressed: () async {
            final uri = Uri.tryParse(url ?? '');
            if (uri != null && await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
          child: const Text('更新'),
        ),
      ],
    );
  }
}